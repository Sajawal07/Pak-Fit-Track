# PakFitTrack — Pre-Launch Action Checklist

This file tracks every manual action required before uploading to Google Play.
Complete each item **in order**.

Contact email: **Sajawal0005@gmail.com**

---

## ✅ AUTOMATED (Already Done by Agent)

- [x] Upload keystore created + backed up (`D:\2026\PakFitTrack-KEYSTORE-BACKUP` + Desktop copy)
- [x] Release signing wired in `android/app/build.gradle.kts`
- [x] `AndroidManifest.xml` — analytics/crashlytics off by default
- [x] Privacy Policy + Terms live on Firebase Hosting
- [x] Support email set to `Sajawal0005@gmail.com` in app + legal pages
- [x] Package id `com.pakfittrack.app`
- [x] GitHub repo: https://github.com/Sajawal07/Pak-Fit-Track

---

## Live legal links (paste into Play Console)

| Page | URL |
|------|-----|
| Privacy Policy | https://pak-fit-track-web.web.app/privacy-policy.html |
| Terms of Service | https://pak-fit-track-web.web.app/terms-of-service.html |
| Home | https://pak-fit-track-web.web.app/ |

---

## 🔴 STEP 1 — Add SHA-1 Fingerprints to Firebase (CRITICAL)

**Where:** Firebase Console → Project **pakfittrack** → Project Settings → Android app `com.pakfittrack.app` → SHA certificate fingerprints

### A. Debug SHA-1
```
2F:A8:5B:D3:EE:38:FD:95:85:E7:8B:CB:7B:CB:9D:33:0A:EC:46:02
```

### B. Upload / Release SHA-1 (add BEFORE Play upload)
```
51:6C:D1:D1:51:7B:24:0F:E6:9E:19:81:35:DC:CF:B5:66:87:D2:91
```
SHA-256:
```
76:B1:A9:A3:00:52:A3:DB:DD:0E:0C:03:85:87:0B:C3:4E:FA:6C:44:F2:4C:3F:27:78:79:B0:B8:40:A7:4F:1A
```

### C. Play App Signing SHA-1 (add AFTER first AAB upload)
Play Console → App signing → copy **App signing key certificate** SHA-1 → paste into Firebase.

Full guide: `docs/SHA_FINGERPRINTS.md`

---

## 🔴 STEP 2 — Install "Delete User Data" Firebase Extension

Firebase Console → Extensions → "Delete User Data"
- Firestore path: `users/{UID}`
- Subcollections: YES
- Trigger: Auth user deletion

---

## 🔴 STEP 3 — Enable App Check Enforcement (after internal test works)

Do NOT enforce until Internal Testing Google Sign-In works with all SHA-1s.

---

## 🔴 STEP 4 — Google Play Data Safety

See `docs/DATA_SAFETY_PLAY_CONSOLE.md`

---

## 🟡 STEP 5 — Build & Internal Testing

```powershell
flutter build appbundle --release
```

Upload `build/app/outputs/bundle/release/app-release.aab` to **Internal testing** first.

---

## 🟢 STEP 6 — Production

Only after internal tests pass → submit for review.

---

## Links
- GitHub: https://github.com/Sajawal07/Pak-Fit-Track
- Firebase app project: https://console.firebase.google.com/project/pakfittrack
- Privacy: https://pak-fit-track-web.web.app/privacy-policy.html
- Terms: https://pak-fit-track-web.web.app/terms-of-service.html
- Contact: Sajawal0005@gmail.com
