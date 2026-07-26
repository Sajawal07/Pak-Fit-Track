/// Single source of truth: what the app ACTUALLY collects at runtime.
/// Use this when filling Google Play → App content → Data safety.
class DataCollectionRegistry {
  DataCollectionRegistry._();

  static const List<DataCollectionItem> items = [
    DataCollectionItem(
      category: 'Email address',
      purpose: 'Account creation and sign-in (Firebase Authentication)',
      shared: 'Firebase / Google (processor)',
      optional: false,
      encryptedInTransit: true,
      userCanDelete: true,
    ),
    DataCollectionItem(
      category: 'Health & fitness',
      purpose:
          'Weight, height, age, goals, food logs, workouts, body measurements, optional steps',
      shared: 'Stored on device; synced to Firestore when signed in',
      optional: false,
      encryptedInTransit: true,
      userCanDelete: true,
    ),
    DataCollectionItem(
      category: 'App interactions (Analytics)',
      purpose:
          'Firebase Analytics: app open, onboarding complete, food logged (meal type only)',
      shared: 'Firebase Analytics (Google)',
      optional: true,
      encryptedInTransit: true,
      userCanDelete: true,
      note:
          'OFF by default. User must enable in Profile → Privacy & data. SDK auto-init disabled in manifest.',
    ),
    DataCollectionItem(
      category: 'Device or other IDs',
      purpose: 'Local device UUID for offline sync queue (not sent to ads)',
      shared: 'Local device only',
      optional: true,
      encryptedInTransit: false,
      userCanDelete: true,
    ),
  ];

  /// NOT collected (declare “No” in Play Console for these):
  static const List<String> notCollected = [
    'Precise location',
    'Contacts',
    'Photos / videos',
    'SMS',
    'Crashlytics',
    'Firebase Cloud Messaging (push tokens)',
    'Financial info',

  ];
}

class DataCollectionItem {
  final String category;
  final String purpose;
  final String shared;
  final bool optional;
  final bool encryptedInTransit;
  final bool userCanDelete;
  final String? note;

  const DataCollectionItem({
    required this.category,
    required this.purpose,
    required this.shared,
    required this.optional,
    required this.encryptedInTransit,
    required this.userCanDelete,
    this.note,
  });
}
