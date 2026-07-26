# Three SHA fingerprints for Google Sign-In

Google Sign-In needs **all** fingerprints that can sign your APK. Missing one causes “works in debug, fails in Play”.

| # | Key | Used when | Where to get SHA-1 |
|---|-----|-----------|-------------------|
| 1 | **Debug** | `flutter run`, local testing | Script below |
| 2 | **Upload / release** | `flutter build appbundle --release` | Your `upload-keystore.jks` |
| 3 | **Play App Signing** | Users install from Play Store | Play Console (Google re-signs the AAB) |

## Add fingerprints in Firebase

Firebase Console → Project settings → Your apps → Android `com.pakfittrack.app` → **Add fingerprint** (SHA-1 and SHA-256 for each).

Also enable the same in [Google Cloud Console](https://console.cloud.google.com) → APIs & Services → Credentials → OAuth Android client if Google Sign-In fails after Firebase is correct.

---

## Upload keystore (created Jul 26, 2026)

**Backup folder (private, NOT in Git):** `D:\2026\PakFitTrack-KEYSTORE-BACKUP\`

| Field | Value |
|-------|--------|
| Alias | `upload` |
| Package | `com.pakfittrack.app` |
| **SHA-1** | `51:6C:D1:D1:51:7B:24:0F:E6:9E:19:81:35:DC:CF:B5:66:87:D2:91` |
| **SHA-256** | `76:B1:A9:A3:00:52:A3:DB:DD:0E:0C:03:85:87:0B:C3:4E:FA:6C:44:F2:4C:3F:27:78:79:B0:B8:40:A7:4F:1A` |

Add these SHA values to Firebase **now**. Passwords are only in the backup folder + `android/key.properties` (gitignored).

---

## 1) Debug SHA-1

**PowerShell (project root):**

```powershell
.\scripts\print_sha.ps1
```

**Or manually:**

```powershell
keytool -list -v -alias androiddebugkey -keystore "$env:USERPROFILE\.android\debug.keystore" -storepass android -keypass android
```

Copy lines starting with `SHA1:` and `SHA256:`.

---

## 2) Release (upload keystore) SHA-1

```powershell
keytool -list -v -keystore android\upload-keystore.jks -alias upload
```

Build release bundle:

```powershell
flutter build appbundle --release
```

---

## 3) Play App Signing SHA-1

After you upload your first AAB to Play Console:

1. Play Console → your app → **Setup** → **App signing** (or **Release** → **Setup** → **App integrity**)
2. Under **App signing key certificate**, copy **SHA-1 certificate fingerprint**
3. Add to Firebase Android app fingerprints

This is **not** the same as your upload key. Play re-signs the app; Firebase must trust Google’s certificate.

---

## Verify Google Sign-In

| Build type | Must work with |
|------------|----------------|
| `flutter run` (debug) | Debug SHA-1 |
| `flutter build apk --release` + local install | Upload keystore SHA-1 |
| Internal / closed / production track from Play | Play App Signing SHA-1 |

If one environment fails, you are almost always missing that row’s SHA-1 in Firebase.
