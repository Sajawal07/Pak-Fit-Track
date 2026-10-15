# Release checklist — Pak Fit Track

See also: `docs/FINAL_GAP_RESOLUTION.md`

## 1. Firebase (launch blockers)

1. Android app **`com.pakfittrack.app`** → download `google-services.json` → `android/app/`
2. **SHA-1 fingerprints** → `docs/SHA_FINGERPRINTS.md`
3. **App Check** → enforce Firestore → `docs/FIREBASE_APP_CHECK.md`
4. `firebase deploy --only firestore:rules`
5. `firebase deploy --only hosting` (privacy/terms HTML)

## 2. Upload keystore

Create `android/key.properties` from `android/key.properties.example` with your production keystore credentials.

```powershell
flutter build appbundle --release
```

Release signing **requires** `android/key.properties` — builds will fail without it.

## 3. Play Console

- Privacy policy URL = `AppLegal.privacyPolicyUrl` (after hosting deploy)
- Data safety = `docs/DATA_SAFETY_PLAY_CONSOLE.md` (analytics **optional**, default off)
- Account deletion = Yes, in-app + web deletion page

## 4. Pre-submit smoke test

- [ ] Google Sign-In on **Play internal track** (uses Play App Signing SHA-1)
- [ ] Analytics **off** by default → enable in Profile → events in DebugView
- [ ] Delete account → deletionRequests/{uid} created, local device data cleared, user signed out
- [ ] Admin processes deletion request via Firebase Console → Firestore + Auth cleaned (see docs/ACCOUNT_DELETION.md)
- [ ] Firestore sync works with App Check **enforced**
