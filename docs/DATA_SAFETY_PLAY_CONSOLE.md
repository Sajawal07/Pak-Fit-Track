# Google Play Data Safety — Pak Fit Track

Match **exactly** what the app collects. Source of truth in code: `lib/core/constants/data_collection_registry.dart`.

## Declare YES

| Data type | Collected | Shared | Purpose | Optional |
|-----------|-----------|--------|---------|----------|
| Email address | Yes | Yes (Firebase Auth / Google) | Account management | No |
| Name | Yes | Yes (Firestore when signed in) | Profile display | No |
| Age | Yes | Yes (Firestore when signed in) | Profile data | No |
| Gender | Yes | Yes (Firestore when signed in) | Profile data | No |
| Height | Yes | Yes (Firestore when signed in) | Profile data | No |
| Weight | Yes | Yes (Firestore when signed in) | Profile data | No |
| Health & fitness (goals, activity level, food logs, weight logs, activity logs) | Yes | Yes (Firestore when signed in) | App functionality | No |
| Steps/activity data | Yes | No (local device only unless synced) | Activity tracking | Yes (requires permission) |
| App interactions (Analytics) | Yes (if user enables) | Yes (Firebase Analytics) | Analytics | **Yes** (default **off**; opt-in in Profile) |
| Device or other IDs | Yes | No (local UUID only) | Offline sync queue | Yes |

## Declare NO

- Location (precise or approximate)
- Contacts, photos, SMS
- Crash logs / Crashlytics (SDK not present in app)
- Push notification token / FCM (firebase_messaging not a dependency)
- Financial info, ads ID, advertising identifier
- Call logs, camera, microphone

## Analytics events actually sent

SDK auto-collection is **disabled** in `AndroidManifest.xml`. Events fire only when user turns **Firebase Analytics** ON (Profile → Privacy & data):

- `app_open` / `daily_active_user`
- `onboarding_complete`
- `food_logged` (parameter: `meal_type` only — not food names)
- `retention_check`

Analytics events are processed by Firebase Analytics (Google) under the `pakfittrack` Firebase project.

## Account deletion

The app implements an account deletion process that requires manual admin action:

1. **In-app flow**: Profile → Settings → Delete account → confirmation → re-authentication → creates `deletionRequests/{uid}` document in Firestore with `status: "pending"` → the app then stops sync, clears the user's local device data (Isar records, prefs keys, local step history, notifications), and signs the user out. **Nothing in the cloud is deleted at this point.**
2. **Email flow**: Users who cannot access the app email `Sajawal0005@gmail.com` from their registered address (the hosted page `https://pak-fit-track-web.web.app/delete-account.html` explains both options).
3. **Admin processing**: An admin manually processes deletion requests per `docs/ACCOUNT_DELETION.md`:
   - Deleting `users/{uid}` **and every document in its subcollections** (`food_logs`, `weight_logs`, `activity_logs`) from Firestore — a parent-document delete alone does NOT remove subcollections (`firebase firestore:delete --recursive users/{uid}`)
   - Deleting the Firebase Authentication user via Firebase Console → Authentication → Users
   - Deleting (or retiring as an audit record) the `deletionRequests/{uid}` record
4. **Local data**: Cleared on the device where the in-app request was submitted. Signing out alone does NOT clear local data.

**Important**: Deletion is NOT automatic. After a deletion request is submitted, an admin must manually process it. The privacy policy and delete-account page describe this as a request-based manual process; the published processing target is **30 days** from receipt (confirmed by the owner, October 2026).

**Other devices**: After deletion, signed-in sessions on other phones cannot sync (auth user gone). Users should delete app data on those devices or reinstall.

## Data retention

- User data is retained in Firestore until an admin processes the deletion request.
- Local device data is cleared on the device when the user submits an in-app deletion request. Signing out keeps local data on the device.
- Deletion request records (`deletionRequests/{uid}`) are retained by the admin only until processing is complete (kept as an audit record with status `"completed"` and the email field removed, if an audit trail is required).

## Data storage

- **On device**: Isar database (profile data, food logs, weight logs, activity logs, custom foods, sync queue), SharedPreferences (settings, preferences, device UUID)
- **Remotely**: Firebase Firestore (profile data, food logs, weight logs, activity logs) under `users/{uid}` and subcollections
- Firebase Auth (account credentials)
- Firebase Analytics (only when user opts in)
- Firebase App Check (Play Integrity for security)

## Security

- Data in transit is encrypted (HTTPS/TLS)
- Firestore security rules enforce user isolation (users can only read/write their own data)
- Re-authentication required before deletion requests
- App Check enforced in Firebase Console for Firestore

## Privacy policy URL

Play Console URL must match `AppLegal.privacyPolicyUrl` in app:
`https://pak-fit-track-web.web.app/privacy-policy.html`

> **Hosting topology (verified October 2026):** the website lives in a
> **separate Firebase project, `pak-fit-track-web`** (project
> `#276284533069`), whose default hosting site serves
> `https://pak-fit-track-web.web.app` — the Play-referenced URL. The app's
> own project is `pakfittrack` (Auth/Firestore/Analytics); its default
> domain `pakfittrack.web.app` serves an **older** copy of the policy and
> is not the Play URL. Firebase CLI v15 has **no `deploy --site` option** —
> select the project explicitly:
>
> ```bash
> firebase deploy --only hosting -P pak-fit-track-web   # → pak-fit-track-web.web.app (canonical)
> # equivalent, using the alias already defined in .firebaserc:
> firebase deploy --only hosting --project hosting
> ```
>
> Run this with a Google account that has access to project
> `pak-fit-track-web`. The `pakfittrack` project needs the owner's account
> and is only relevant for Firestore-rules deploys, not content updates.
> If you change the default project (`firebase use ...`), remember that a
> plain `firebase deploy --only hosting` will then publish to whichever
> project is active — always pass `-P pak-fit-track-web` for website deploys.

Deploy hosted copy of the policy **and** the account-deletion page:

```bash
firebase deploy --only hosting -P pak-fit-track-web
```

After deploying, verify all three pages: `privacy-policy.html` (shows the
current "Last updated" date), `delete-account.html` (HTTP 200, not 404),
and `terms-of-service.html`.

There is no CI/CD for hosting — deployment is always manual. Last deployed
and verified live: **October 15, 2026** (timeframe finalized at 30 days).

## Privacy contact

Email: **Sajawal0005@gmail.com**
