# Play Store — final readiness (Pak Fit Track)

Contact for Play Console / privacy: **Sajawal0005@gmail.com**

## Live legal links (use in Play Console)

| Page | URL |
|------|-----|
| Privacy Policy | https://pak-fit-track-web.web.app/privacy-policy.html |
| Terms of Service | https://pak-fit-track-web.web.app/terms-of-service.html |
| Home | https://pak-fit-track-web.web.app/ |

## Upload signing key

- Keystore: `android/upload-keystore.jks` (gitignored)
- Config: `android/key.properties` (gitignored)
- **Full backup (passwords):** `D:\2026\PakFitTrack-KEYSTORE-BACKUP\`
- SHA fingerprints: `docs/SHA_FINGERPRINTS.md`

**Never lose the backup folder.** Without it you cannot update the Play listing.

## Build AAB for Play

```powershell
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

## Play Console checklist

1. Create app → package `com.pakfittrack.app`
2. Privacy policy URL → link above
3. Contact email → `Sajawal0005@gmail.com`
4. Data safety → `docs/DATA_SAFETY_PLAY_CONSOLE.md`
5. Add **upload SHA-1** + later **Play App Signing SHA-1** to Firebase Android app
6. Upload AAB to Internal testing first
7. Store listing: screenshots, short/full description, icon 512, feature graphic 1024x500

## Firebase note

App Auth/Firestore project in `google-services.json` is still **`pakfittrack`**.  
Hosting-only project for legal pages is **`pak-fit-track-web`** (this account can deploy it).

If Google Sign-In fails on release builds, add the upload keystore SHA-1 to the **pakfittrack** Firebase Android app (`com.pakfittrack.app`).
