import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../core/constants/prefs_keys.dart';

// ── Firebase Auth instance (null-safe when Firebase is not configured) ────
final firebaseAuthProvider = Provider<FirebaseAuth?>((ref) {
  if (!firebaseAvailable) return null;
  try {
    return FirebaseAuth.instance;
  } catch (_) {
    return null;
  }
});

// ── Auth state stream ─────────────────────────────────────────────────────
final authStateProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  if (auth == null) return Stream.value(null);
  // Do NOT use Stream.timeout here — timeout fires on quiet gaps between
  // emissions and falsely signs the user out every ~8s (login-screen loop).
  return auth.userChanges();
});

/// Firebase uid only. Empty string when signed out (no guest sessions).
String resolveActiveUid({SharedPreferences? prefs, FirebaseAuth? auth}) {
  final firebaseUser = auth?.currentUser;
  if (firebaseUser != null) return firebaseUser.uid;
  return '';
}

/// True when a Firebase user is signed in.
final sessionActiveProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider).valueOrNull != null;
});

/// Set to true once Firebase has emitted the first auth event.
final authBootstrapCompleteProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return !authState.isLoading;
});

final currentUidProvider = Provider<String>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return resolveActiveUid(auth: auth);
});

// ── Auth Actions ─────────────────────────────────────────────────────────
class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final FirebaseAuth? _auth;
  final Ref _ref;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        '468407198380-0k4e3ekhdmjdouthf8sljg5mdfgdrr9u.apps.googleusercontent.com',
  );

  AuthNotifier(this._auth, this._ref) : super(const AsyncValue.loading()) {
    if (_auth != null) {
      _auth.userChanges().listen((user) {
        state = AsyncValue.data(user);
      });
    } else {
      state = const AsyncValue.data(null);
    }
  }

  String getReadableErrorMessage(dynamic error, {bool isGoogleSignIn = false}) {
    final raw = error.toString();
    final lower = raw.toLowerCase();

    // Google Sign-In DEVELOPER_ERROR (ApiException: 10 / obfuscated j: 10)
    if (lower.contains('apiexception: 10') ||
        lower.contains('api_exception: 10') ||
        (lower.contains('sign_in_failed') &&
            (lower.contains(': 10') || lower.contains(' 10')))) {
      return 'Google Sign-In configuration error: The Play Store App Signing SHA-1 fingerprint needs to be added in Firebase Console (com.pakfittrack.app).';
    }

    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-credential':
          return 'Authentication failed. Please check your credentials or try again.';
        case 'wrong-password':
          return 'Incorrect email or password. Please check your credentials or sign up.';
        case 'user-not-found':
          return 'No account found with this email. Please sign up first.';
        case 'user-disabled':
          return 'This account has been disabled. Please contact support.';
        case 'email-already-in-use':
          return 'An account already exists with this email address.';
        case 'invalid-email':
          return 'The email address is invalid. Please enter a valid email.';
        case 'weak-password':
          return 'The password is too weak. Please use a stronger password (minimum 6 characters).';
        case 'operation-not-allowed':
          return 'This sign-in method is not enabled. Please contact support.';
        case 'network-request-failed':
          return 'Network error. Please check your internet connection and try again.';
        default:
          return error.message ?? 'Authentication failed. Please try again.';
      }
    }
    if (lower.contains('socketexception') ||
        lower.contains('network') ||
        lower.contains('failed host lookup') ||
        lower.contains('connectivity')) {
      return 'No internet connection. Please check your network connection and try again.';
    }
    return raw
        .replaceAll('Exception: ', '')
        .replaceAll('PlatformException(', '')
        .replaceAll(')', '');
  }

  Future<void> signInWithEmail(String email, String password) async {
    if (_auth == null) {
      state = AsyncValue.error('Firebase not configured', StackTrace.current);
      throw 'Firebase not configured';
    }
    state = const AsyncValue.loading();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e, st) {
      final readable = getReadableErrorMessage(e);
      state = AsyncValue.error(readable, st);
      throw readable;
    }
  }

  Future<void> registerWithEmail(String email, String password) async {
    if (_auth == null) {
      state = AsyncValue.error('Firebase not configured', StackTrace.current);
      throw 'Firebase not configured';
    }
    state = const AsyncValue.loading();
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await cred.user?.sendEmailVerification();
      try {
        final prefs = _ref.read(sharedPreferencesProvider);
        await prefs.setInt(
          PrefsKeys.lastVerificationEmailSentAtMs,
          DateTime.now().millisecondsSinceEpoch,
        );
      } catch (_) {}
    } catch (e, st) {
      final readable = getReadableErrorMessage(e);
      state = AsyncValue.error(readable, st);
      throw readable;
    }
  }

  /// Returns `true` if sign-in completed, `false` if user cancelled the picker.
  Future<bool> signInWithGoogle() async {
    final auth = _auth;
    if (auth == null) {
      state = AsyncValue.error('Firebase not configured', StackTrace.current);
      throw 'Firebase not configured';
    }
    state = const AsyncValue.loading();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // Cancelled by user — restore state, do not navigate away.
        state = AsyncValue.data(auth.currentUser);
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);
      state = AsyncValue.data(userCredential.user);
      return true;
    } catch (e, st) {
      final readable = getReadableErrorMessage(e, isGoogleSignIn: true);
      state = AsyncValue.error(readable, st);
      debugPrint('[Auth] Google Sign-In failed: $e -> $readable');
      throw readable;
    }
  }

  Future<void> sendPasswordReset(String email) async {
    if (_auth == null) {
      throw Exception('Firebase not configured');
    }
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      throw Exception(getReadableErrorMessage(e));
    }
  }

  Future<void> signOut() async {
    await _auth?.signOut();
    await _googleSignIn.signOut();
    // Clear any legacy guest prefs from older installs.
    final prefs = _ref.read(sharedPreferencesProvider);
    await prefs.remove(PrefsKeys.guestUid);
    await prefs.remove(PrefsKeys.guestImportPromptedForUid);
    state = const AsyncValue.data(null);
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier(ref.watch(firebaseAuthProvider), ref);
});
