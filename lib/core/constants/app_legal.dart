/// Legal URLs and copy for Play Store compliance.
/// Update [privacyPolicyUrl] when your hosted policy is live.
class AppLegal {
  AppLegal._();

  static const String appName = 'Pak Fit Track';
  static const String supportEmail = 'Sajawal0005@gmail.com';

  /// Hosted privacy policy (Play Console requires a live HTTPS URL).
  /// MUST match the URL entered in the Play Console. The same content is
  /// also served from the project's default hosting domain
  /// (pakfittrack.web.app), but this canonical site is the one referenced
  /// by the Play listing.
  static const String privacyPolicyUrl =
      'https://pak-fit-track-web.web.app/privacy-policy.html';

  static const String termsOfServiceUrl =
      'https://pak-fit-track-web.web.app/terms-of-service.html';

  /// Hosted account-deletion information page (linked from the privacy
  /// policy and the in-app policy text).
  static const String accountDeletionUrl =
      'https://pak-fit-track-web.web.app/delete-account.html';

  static const String healthDisclaimer = '''
Pak Fit Track provides general fitness and nutrition information for educational purposes only. It is not a medical device and does not provide medical advice, diagnosis, or treatment.

Always consult a qualified healthcare professional before starting any diet or exercise program, especially if you have a medical condition, are pregnant, or take medication.

Calorie, BMR, TDEE, and exercise burn estimates are approximations and may not match your individual metabolism.''';

  static const String privacySummary = '''
We collect account information (email), profile data (age, weight, height, goals), food and activity logs, and optional step data when you grant permission.

Data is stored on your device and, when signed in, synced to Firebase (Google Cloud) under your account.

Firebase Analytics (optional): app opens and feature usage — you can turn this off under Profile → Privacy & data.

We do NOT use Crashlytics, push notification tokens, or advertising IDs.

You can request account deletion from Profile → Delete Account. This submits a deletion request: your local device data is cleared right away, and an administrator then manually deletes your account and cloud data. Signing out does not delete your data.''';
}
