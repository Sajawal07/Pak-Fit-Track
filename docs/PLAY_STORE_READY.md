# Play Store — final readiness (Pak Fit Track)

Contact for Play Console / privacy: **Sajawal0005@gmail.com**

## Live legal links (use in Play Console)

| Page | URL |
|------|-----|
| Privacy Policy | https://pak-fit-track-web.web.app/privacy-policy.html |
| Terms of Service | https://pak-fit-track-web.web.app/terms-of-service.html |
| Home | https://pak-fit-track-web.app/ |
| Account Deletion | https://pak-fit-track-web.web.app/delete-account.html |

## Upload signing key

- Config: `android/key.properties` (gitignored — create from `android/key.properties.example`)
- SHA fingerprints: `docs/SHA_FINGERPRINTS.md`
- **Important:** Keep your keystore file secure and backed up. Losing it prevents future app updates.

## Build AAB for Play

```powershell
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

Release builds **require** `android/key.properties`. Without it, the build will fail with a clear error message.

## Play Console checklist

1. Create app → package `com.pakfittrack.app`
2. Privacy policy URL → link above
3. Contact email → `Sajawal0005@gmail.com`
4. Data safety → `docs/DATA_SAFETY_PLAY_CONSOLE.md`
5. Add **upload SHA-1** + later **Play App Signing SHA-1** to Firebase Android app (`com.pakfittrack.app`)
6. Upload AAB to Internal testing first
7. Store listing: screenshots, short/full description, icon 512, feature graphic 1024x500
8. Complete Health Apps declaration in Play Console

## Firebase note

App Auth/Firestore project in `google-services.json` is `pakfittrack`.
Hosting-only project for legal pages is `pak-fit-track-web`.

If Google Sign-In fails on release builds, add the upload keystore SHA-1 to the **pakfittrack** Firebase Android app (`com.pakfittrack.app`).
