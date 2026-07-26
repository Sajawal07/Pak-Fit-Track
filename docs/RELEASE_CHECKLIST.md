# Release checklist — Pak Fit Track

See also: `docs/FINAL_GAP_RESOLUTION.md`

## 1. Firebase (launch blockers)

1. Android app **`com.pakfittrack.app`** → download `google-services.json` → `android/app/`
2. **Three SHA-1 fingerprints** → `docs/SHA_FINGERPRINTS.md` + `.\scripts\print_sha.ps1`
3. Install extension **Delete User Data** → `docs/FIREBASE_DELETE_USER_DATA.md`
4. **App Check** → enforce Firestore → `docs/FIREBASE_APP_CHECK.md`
5. `firebase deploy --only firestore:rules`
6. `firebase deploy --only hosting` (privacy/terms HTML)

## 2. Upload keystore

```powershell
keytool -genkey -v -keystore android\upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Copy `android\key.properties.example` → `android\key.properties`

```powershell
flutter build appbundle --release
```

## 3. Play Console

- Privacy policy URL = `AppLegal.privacyPolicyUrl` (after hosting deploy)
- Data safety = `docs/DATA_SAFETY_PLAY_CONSOLE.md` (analytics **optional**, default off)
- Account deletion = Yes, in-app

## 4. Pre-submit smoke test

- [ ] Google Sign-In on **Play internal track** (uses Play App Signing SHA-1)
- [ ] Analytics **off** by default → enable in Profile → events in DebugView
- [ ] Delete account → Firestore empty; extension logs clean in Functions
- [ ] Firestore sync works with App Check **enforced**
