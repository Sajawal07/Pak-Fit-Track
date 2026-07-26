/// SharedPreferences keys — keep in sync with account deletion wipe list.
class PrefsKeys {
  PrefsKeys._();

  static const guestUid = 'guest_uid';
  static const deviceUuid = 'device_uuid';
  static const stepsRationaleShown = 'steps_permission_rationale_shown';
  static const stepOffset = 'step_offset';
  static const stepOffsetDate = 'step_offset_date';
  static const analyticsEnabled = 'firebase_analytics_enabled';
  static const stepTrackingEnabled = 'step_tracking_enabled';
  static const guestImportPromptedForUid = 'guest_import_prompted_for_uid';
  static const lastVerificationEmailSentAtMs = 'last_verification_email_sent_at_ms';
  /// Preferred weight display unit: `kg` or `lbs`. Storage remains kg.
  static const weightUnit = 'weight_unit';

  /// All keys cleared on account / guest data deletion.
  static const deletableOnAccountRemoval = [
    guestUid,
    deviceUuid,
    stepsRationaleShown,
    stepOffset,
    stepOffsetDate,
    analyticsEnabled,
    stepTrackingEnabled,
    guestImportPromptedForUid,
    lastVerificationEmailSentAtMs,
    weightUnit,
  ];
}
