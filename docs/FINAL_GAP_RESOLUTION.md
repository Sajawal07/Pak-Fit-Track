# Final gap resolution — status

| Gap | Resolution | Where |
|-----|------------|--------|
| SDK auto-init before opt-in | Analytics/Crashlytics disabled in manifest; enabled only in `main.dart` | `AndroidManifest.xml`, `main.dart` |
| Analytics default | **Opt-in** (default `false`); user enables in Profile | `PrefsKeys`, `PrivacyPreferencesService` |
| 3× SHA for Google Sign-In | Documented | `docs/SHA_FINGERPRINTS.md`, `scripts/print_sha.ps1` |
| Delete during bad network | Client-side deletion request flow (`deletionRequests/{uid}`) | `docs/ACCOUNT_DELETION.md` |
| App Check enforcement | Client: Play Integrity; enforce in Console | `docs/FIREBASE_APP_CHECK.md`, `main.dart` |
| Data Safety form | Registry matches runtime | `data_collection_registry.dart`, `DATA_SAFETY_PLAY_CONSOLE.md` |
| Target API 36 | Updated to API 36 for Google Play compliance | `android/app/build.gradle.kts` |
| Release signing safety | Build fails if `key.properties` missing; no debug fallback | `android/app/build.gradle.kts` |
| Privacy Policy | Comprehensive HTML policy covering all data types | `docs/privacy-policy.html`, `assets/legal/privacy_policy.txt` |
| Web account deletion | Public deletion request page | `https://pak-fit-track-web.web.app/delete-account.html` |

## Your manual checklist

- [ ] Review and process deletion requests (see `docs/ACCOUNT_DELETION.md`)
- [ ] Add **SHA-1** fingerprints (see `SHA_FINGERPRINTS.md`)
- [ ] **Enforce** App Check for Firestore in Console (see `FIREBASE_APP_CHECK.md`)
- [ ] `firebase deploy --only firestore:rules,hosting`
- [ ] Deploy privacy/terms/deletion pages to Firebase Hosting
- [ ] Play Data safety form = copy from `DATA_SAFETY_PLAY_CONSOLE.md`
- [ ] Complete Health Apps declaration in Play Console
- [ ] Complete account deletion section in Play Console Data Safety form
