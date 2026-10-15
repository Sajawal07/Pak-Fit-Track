/// SharedPreferences keys — keep in sync with account deletion wipe list.
class PrefsKeys {
  PrefsKeys._();

  /// Legacy guest key — cleared on startup/sign-out; no longer used for sessions.
  static const guestUid = 'guest_uid';
  static const deviceUuid = 'device_uuid';
  static const stepsRationaleShown = 'steps_permission_rationale_shown';
  static const stepOffset = 'step_offset';
  static const stepOffsetDate = 'step_offset_date';
  static const analyticsEnabled = 'firebase_analytics_enabled';
  static const stepTrackingEnabled = 'step_tracking_enabled';
  /// Legacy import flag — cleared on sign-out.
  static const guestImportPromptedForUid = 'guest_import_prompted_for_uid';
  static const lastVerificationEmailSentAtMs =
      'last_verification_email_sent_at_ms';
  /// Preferred weight display unit: `kg` or `lbs`. Storage remains kg.
  static const weightUnit = 'weight_unit';

  /// All keys cleared on account deletion.
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
