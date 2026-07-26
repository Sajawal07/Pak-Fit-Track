# Pak Fit Track

Pakistan-focused nutrition and fitness tracking (Flutter + Firebase).

**Contact:** [Sajawal0005@gmail.com](mailto:Sajawal0005@gmail.com)

## Live legal pages (Play Store)

- Privacy: https://pak-fit-track-web.web.app/privacy-policy.html
- Terms: https://pak-fit-track-web.web.app/terms-of-service.html

Full Play readiness guide: **`docs/PLAY_STORE_READY.md`**

## Play Store checklist

1. **SHA fingerprints** — `docs/SHA_FINGERPRINTS.md` + `.\scripts\print_sha.ps1`
2. **Firebase** — `com.pakfittrack.app`, `google-services.json`, Delete User Data extension
3. **App Check** — Enforce Firestore in Console — `docs/FIREBASE_APP_CHECK.md`
4. **Hosting (legal pages)** — `firebase deploy --only hosting --project pak-fit-track-web`
5. **Data Safety** — `docs/DATA_SAFETY_PLAY_CONSOLE.md` (analytics optional, default off)
6. **Signed AAB** — requires local `android/key.properties` + `upload-keystore.jks` (never commit)

## Development

```bash
flutter pub get
flutter run
```

## Release build

```powershell
flutter build appbundle --release
```

## Account deletion

Profile → Delete account (removes Firebase Auth user, Firestore data, and local logs).
