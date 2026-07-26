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

// ── Auth state: emits null (guest) if Firebase not configured ─────────────
final authStateProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  if (auth == null) return Stream.value(null);
  // userChanges() also emits on user.reload() / token refresh,
  // which is required for emailVerified updates to propagate reliably.
  return auth.userChanges().timeout(
    const Duration(seconds: 8),
    onTimeout: (sink) {
      // If Firebase takes > 8 seconds, emit null to unblock the router.
      // This allows the app to fallback to Guest/Offline mode instead of being permanently stuck.
      // The stream remains open, so if Firebase resolves later, the router will redirect automatically.
      sink.add(null);
    },
  );
});

/// Resolves uid from Firebase persisted session or explicit guest id.
/// Returns empty string when no session exists (never a synthetic `"guest"`).
String resolveActiveUid({SharedPreferences? prefs, FirebaseAuth? auth}) {
  final firebaseUser = auth?.currentUser;
  if (firebaseUser != null) return firebaseUser.uid;

  final guestUid = prefs?.getString(PrefsKeys.guestUid);
  if (guestUid != null && guestUid.isNotEmpty) return guestUid;
  return '';
}

/// True when a Firebase user or an explicit guest profile session exists.
final sessionActiveProvider = Provider<bool>((ref) {
  final authUser = ref.watch(authStateProvider).value;
  if (authUser != null) return true;
  final guestUid =
      ref.watch(sharedPreferencesProvider).getString(PrefsKeys.guestUid);
  return guestUid != null && guestUid.isNotEmpty;
});

/// Set to true once Firebase (or offline mode) has emitted the first auth event.
final authBootstrapCompleteProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return !authState.isLoading;
});

// ── Current UID (Firebase user uid OR explicit guest id; empty when signed out) ─
final currentUidProvider = Provider<String>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  return resolveActiveUid(prefs: prefs, auth: auth);
});

// ── Auth Actions ─────────────────────────────────────────────────────────
class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final FirebaseAuth? _auth;
  final Ref _ref;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthNotifier(this._auth, this._ref) : super(const AsyncValue.loading()) {
    if (_auth != null) {
      // Same stream as authStateProvider — avoids desync between router and actions.
      _auth.userChanges().listen((user) {
        state = AsyncValue.data(user);
      });
    } else {
      // No Firebase – always guest
      state = const AsyncValue.data(null);
    }
  }

  String getReadableErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-credential':
        case 'wrong-password':
        case 'user-not-found':
          return 'Incorrect email or password. Please check your credentials or sign up.';
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
    final errorStr = error.toString().toLowerCase();
    if (errorStr.contains('socketexception') || 
        errorStr.contains('network') || 
        errorStr.contains('failed host lookup') ||
        errorStr.contains('connectivity')) {
      return 'No internet connection. Please check your network connection and try again.';
    }
    return error.toString().replaceAll('Exception: ', '');
  }

  Future<void> signInWithEmail(String email, String password) async {
    if (_auth == null) {
      state = AsyncValue.error('Firebase not configured', StackTrace.current);
      return;
    }
    state = const AsyncValue.loading();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e, st) {
      final readable = getReadableErrorMessage(e);
      state = AsyncValue.error(readable, st);
      rethrow;
    }
  }

  Future<void> registerWithEmail(String email, String password) async {
    if (_auth == null) {
      state = AsyncValue.error('Firebase not configured', StackTrace.current);
      return;
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
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    if (_auth == null) {
      state = AsyncValue.error('Firebase not configured', StackTrace.current);
      return;
    }
    state = const AsyncValue.loading();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        state = AsyncValue.error('Google sign-in was cancelled.', StackTrace.current);
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      state = AsyncValue.data(userCredential.user);
    } catch (e, st) {
      final readable = getReadableErrorMessage(e);
      state = AsyncValue.error(readable, st);
      rethrow;
    }
  }

  Future<void> continueAsGuest() async {
    final prefs = _ref.read(sharedPreferencesProvider);
    final existing = prefs.getString(PrefsKeys.guestUid);
    if (existing == null) {
      await prefs.setString(
          PrefsKeys.guestUid, 'guest_${DateTime.now().millisecondsSinceEpoch}');
    }
    state = const AsyncValue.data(null);
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
    final prefs = _ref.read(sharedPreferencesProvider);
    await prefs.remove(PrefsKeys.guestUid);
    state = const AsyncValue.data(null);
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier(ref.watch(firebaseAuthProvider), ref);
});
