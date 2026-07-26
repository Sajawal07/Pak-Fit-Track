# Final gap resolution — status

| Gap | Resolution | Where |
|-----|------------|--------|
| SDK auto-init before opt-in | Analytics/Crashlytics disabled in manifest & plist; enabled only in `main.dart` | `AndroidManifest.xml`, `Info.plist`, `main.dart` |
| Analytics default | **Opt-in** (default `false`); user enables in Profile | `PrefsKeys`, `PrivacyPreferencesService` |
| 3× SHA for Google Sign-In | Documented + script | `docs/SHA_FINGERPRINTS.md`, `scripts/print_sha.ps1` |
| Delete during bad network | Client delete + **Delete User Data** extension | `docs/FIREBASE_DELETE_USER_DATA.md` |
| App Check enforcement | Client: Play Integrity; enforce in Console | `docs/FIREBASE_APP_CHECK.md`, `main.dart` |
| Data Safety form | Registry matches runtime | `data_collection_registry.dart`, `DATA_SAFETY_PLAY_CONSOLE.md` |

## Your manual checklist

- [ ] Install **Delete User Data** extension (see `FIREBASE_DELETE_USER_DATA.md`)
- [ ] Add **3 SHA-1** fingerprints (see `SHA_FINGERPRINTS.md`)
- [ ] **Enforce** App Check for Firestore in Console (see `FIREBASE_APP_CHECK.md`)
- [ ] `firebase deploy --only firestore:rules,hosting`
- [ ] Play Data safety form = copy from `DATA_SAFETY_PLAY_CONSOLE.md`
