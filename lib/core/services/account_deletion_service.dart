import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';
import '../../providers/auth_provider.dart';

final accountDeletionServiceProvider =
    Provider<AccountDeletionService>((ref) {
  return AccountDeletionService(ref);
});

/// Represents the result of a deletion request operation.
class DeletionResult {
  final bool success;
  final String message;
  final bool alreadyPending;

  const DeletionResult({
    required this.success,
    required this.message,
    this.alreadyPending = false,
  });
}

/// Result of a re-authentication operation.
class ReauthResult {
  final bool success;
  final String message;
  final bool requiresPassword;

  const ReauthResult({
    required this.success,
    required this.message,
    this.requiresPassword = false,
  });
}

/// Manages the account deletion request flow.
///
/// The client only submits a deletion request to Firestore.
/// The actual Firebase Auth account and associated user data
/// will be deleted manually by the app owner/admin after reviewing
/// the request. No Cloud Functions or Blaze plan are required.
///
/// Flow:
/// 1. Check for existing pending deletion request
/// 2. Perform re-authentication (via [performReauthentication])
/// 3. Submit the deletion request (via [submitDeletionRequest])
class AccountDeletionService {
  final Ref _ref;
  AccountDeletionService(this._ref);

  FirebaseFirestore? get _db =>
      firebaseAvailable ? FirebaseFirestore.instance : null;

  FirebaseAuth? get _auth =>
      firebaseAvailable ? FirebaseAuth.instance : null;

  /// Checks if the current user already has a pending deletion request.
  Future<bool> hasPendingRequest() async {
    final uid = _getCurrentUid();
    if (uid.isEmpty) return false;
    final db = _db;
    if (db == null) return false;

    try {
      final doc = await db.collection('deletionRequests').doc(uid).get();
      return doc.exists && doc.data()?['status'] == 'pending';
    } catch (_) {
      return false;
    }
  }

  /// Performs re-authentication based on the user's existing auth provider.
  ///
  /// If the user has an email/password provider linked, returns a result
  /// indicating that a password dialog should be shown. The caller must
  /// then call [reauthenticateWithPassword] with the user's password.
  ///
  /// If the user only has Google sign-in, initiates Google re-sign-in
  /// and returns the result directly.
  Future<ReauthResult> performReauthentication() async {
    final auth = _auth;
    final user = auth?.currentUser;
    if (user == null) {
      return const ReauthResult(
        success: false,
        message: 'You must be signed in.',
      );
    }

    final hasPasswordProvider = user.providerData.any(
      (p) => p.providerId == 'password',
    );

    if (hasPasswordProvider) {
      return const ReauthResult(
        success: false,
        message: 'password_required',
        requiresPassword: true,
      );
    }

    return await _reauthenticateWithGoogle();
  }

  /// Re-authenticates with email and password after [performReauthentication]
  /// returns a result indicating [requiresPassword] is true.
  Future<ReauthResult> reauthenticateWithPassword(String password) async {
    final auth = _auth;
    final user = auth?.currentUser;
    if (user == null) {
      return const ReauthResult(
        success: false,
        message: 'You must be signed in.',
      );
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email ?? '',
        password: password,
      );
      await user.reauthenticateWithCredential(credential);
      return const ReauthResult(
        success: true,
        message: 'Re-authentication successful.',
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          return const ReauthResult(
            success: false,
            message: 'Incorrect password. Please try again.',
          );
        case 'user-not-found':
          return const ReauthResult(
            success: false,
            message: 'Account not found. Please try again.',
          );
        case 'requires-recent-login':
          return const ReauthResult(
            success: false,
            message:
                'Your session expired. Please sign in again.',
          );
        case 'network-request-failed':
          return const ReauthResult(
            success: false,
            message:
                'Network error. Please check your internet connection.',
          );
        default:
          return const ReauthResult(
            success: false,
            message: 'Authentication failed. Please try again.',
          );
      }
    } catch (e) {
      return const ReauthResult(
        success: false,
        message: 'Authentication failed. Please try again.',
      );
    }
  }

  /// Submits the deletion request to Firestore.
  ///
  /// Must be called after successful re-authentication.
  /// Checks for existing pending request before creating a new one.
  Future<DeletionResult> submitDeletionRequest() async {
    final auth = _auth;
    final user = auth?.currentUser;
    final uid = user?.uid ?? _ref.read(currentUidProvider) ?? '';

    if (uid.isEmpty) {
      return const DeletionResult(
        success: false,
        message: 'You must be signed in to request account deletion.',
      );
    }

    final db = _db;
    if (db == null) {
      return const DeletionResult(
        success: false,
        message: 'Firebase is not configured. Please try again later.',
      );
    }

    try {
      final deletionRef = db.collection('deletionRequests').doc(uid);
      final existing = await deletionRef.get();
      if (existing.exists && existing.data()?['status'] == 'pending') {
        return const DeletionResult(
          success: false,
          message: 'Your account deletion request is already pending.',
          alreadyPending: true,
        );
      }

      await deletionRef.set({
        'uid': uid,
        'email': user?.email ?? '',
        'requestedAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      });

      return const DeletionResult(
        success: true,
        message:
            'Your account deletion request has been submitted successfully. Our team will process your request.',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return const DeletionResult(
          success: false,
          message:
              'Your session expired. Please sign in again and try again.',
        );
      }
      return const DeletionResult(
        success: false,
        message: 'Authentication error. Please try again.',
      );
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        return const DeletionResult(
          success: false,
          message:
              'You do not have permission to submit a deletion request.',
        );
      }
      if (e.code == 'unavailable' || e.code == 'network-request-failed') {
        return const DeletionResult(
          success: false,
          message:
              'Network error. Please check your internet connection and try again.',
        );
      }
      return const DeletionResult(
        success: false,
        message: 'An unexpected error occurred. Please try again.',
      );
    } catch (e) {
      return const DeletionResult(
        success: false,
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  Future<ReauthResult> _reauthenticateWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return const ReauthResult(
          success: false,
          message: 'Re-authentication was cancelled.',
        );
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final auth = _auth;
      if (auth == null) {
        return const ReauthResult(
          success: false,
          message: 'Firebase is not configured.',
        );
      }
      await auth.currentUser!.reauthenticateWithCredential(credential);
      return const ReauthResult(
        success: true,
        message: 'Re-authentication successful.',
      );
    } catch (e) {
      final raw = e.toString().toLowerCase();
      if (raw.contains('cancel') || raw.contains('cancelled')) {
        return const ReauthResult(
          success: false,
          message: 'Re-authentication was cancelled.',
        );
      }
      return const ReauthResult(
        success: false,
        message: 'Google re-sign-in failed. Please try again.',
      );
    }
  }

  String _getCurrentUid() {
    final auth = _auth;
    final user = auth?.currentUser;
    if (user != null) return user.uid;
    return _ref.read(currentUidProvider);
  }
}
