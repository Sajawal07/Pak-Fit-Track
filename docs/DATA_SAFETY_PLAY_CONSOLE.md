# Google Play Data safety — Pak Fit Track

Match **exactly** what the app collects. Source of truth in code: `lib/core/constants/data_collection_registry.dart`.

## Declare YES

| Data type | Collected | Shared | Purpose | Optional |
|-----------|-----------|--------|---------|----------|
| Email address | Yes | Yes (Firebase) | Account management | No |
| Health & fitness | Yes | Yes (Firestore when signed in) | App functionality | No |
| App interactions / Analytics | Yes (if user enables) | Yes (Firebase Analytics) | Analytics | **Yes** (default **off**; opt-in in Profile) |
| Device or other IDs | Yes | No (local UUID only) | App functionality | Yes |

## Declare NO

- Location (precise or approximate)
- Contacts, photos, SMS
- Crash logs / Crashlytics (not in app)
- Push notification token / FCM (dependency removed)
- Financial info, ads ID

## Analytics events actually sent

SDK auto-collection is **disabled** in Android/iOS config. Events fire only when user turns **Firebase Analytics** ON (Profile → Privacy & data):

- `app_open` / `daily_active_user`
- `onboarding_complete`
- `food_logged` (parameter: `meal_type` only — not food names)
- `retention_check`

## Account deletion

Profile → Delete account removes:

- Firebase Authentication user
- Firestore `users/{uid}` and subcollections `food_logs`, `weight_logs`, `activity_logs` (verified empty)
- Local Isar logs for that user, custom foods, sync queue
- SharedPreferences keys listed in `PrefsKeys.deletableOnAccountRemoval`

**Other devices:** After deletion, signed-in sessions on other phones cannot sync (auth user gone). User should delete app data on those devices or reinstall.

## Privacy policy URL

Play Console URL must match `AppLegal.privacyPolicyUrl` in app.

Deploy hosted copy:

```bash
firebase deploy --only hosting
```

Default public URLs (after deploy):

- https://pakfittrack.web.app/privacy-policy.html
- https://pakfittrack.web.app/terms-of-service.html

In-app full policy is also bundled under `assets/legal/` (works offline).
