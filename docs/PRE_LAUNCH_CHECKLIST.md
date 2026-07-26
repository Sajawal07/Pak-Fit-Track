# PakFitTrack — Pre-Launch Action Checklist

This file tracks every manual action required before uploading to Google Play.
Complete each item **in order**.

---

## ✅ AUTOMATED (Already Done by Agent)

- [x] `AndroidManifest.xml` — `firebase_analytics_collection_enabled = false`
- [x] `AndroidManifest.xml` — `firebase_crashlytics_collection_enabled = false`
- [x] `Info.plist` — `FIREBASE_ANALYTICS_COLLECTION_ENABLED = false`
- [x] `Info.plist` — `FirebaseCrashlyticsCollectionEnabled = false`
- [x] `main.dart` — Analytics enabled only AFTER user prefs loaded
- [x] `main.dart` — Firebase App Check (PlayIntegrity) initialized
- [x] `google-services.json` — updated for `com.pakfittrack.app`
- [x] `firebase.json` — Firestore rules + Hosting configured
- [x] `firestore.rules` — deployed to production
- [x] `public/` — Privacy Policy + Terms of Service deployed to `pakfittrack.web.app`
- [x] `scripts/print_sha.ps1` — SHA extractor script created

---

## 🔴 STEP 1 — Add SHA-1 Fingerprints to Firebase (CRITICAL)

**Where:** Firebase Console → Project Settings → `com.pakfittrack.app` → SHA certificate fingerprints

Add these **3 keys** (in this order):

### A. Debug SHA-1 (add NOW — enables local Google Sign-In)
```
2F:A8:5B:D3:EE:38:FD:95:85:E7:8B:CB:7B:CB:9D:33:0A:EC:46:02
```

### B. Release SHA-1 (add BEFORE building release AAB)
Run this after creating your `.jks` release keystore:
```powershell
.\scripts\print_sha.ps1
```
Or manually:
```
keytool -list -v -keystore android\app\YOUR_KEY.jks -alias YOUR_ALIAS
```

### C. Play App Signing SHA-1 (add AFTER first internal track upload)
1. Upload `.aab` to Play Console → Internal Testing track
2. Go to: **Release → Setup → App Integrity → App Signing**
3. Copy the `SHA-1 certificate fingerprint`
4. Paste it into Firebase under the same Android app

---

## 🔴 STEP 2 — Install "Delete User Data" Firebase Extension

**Where:** Firebase Console → Extensions → Search "Delete User Data"

**Why:** Client-side deletion can silently fail if user loses connectivity.
This extension runs on Google's backend and guarantees atomic wipes.

**Configuration:**
- Cloud Firestore path: `users/{UID}`
- Enable subcollection deletion: ✅ YES
- Trigger: Auth user deletion

---

## 🔴 STEP 3 — Enable App Check Enforcement

**Order matters:** Do this ONLY AFTER internal testing is confirmed working.
Enforcing too early will lock out development builds.

1. Go to: Firebase Console → App Check
2. Register your Android app (`com.pakfittrack.app`) → Provider: **Play Integrity**
3. Once internal testing passes, click **Enforce** next to **Cloud Firestore**

> ⚠️ Do NOT enforce App Check before your internal test track confirms
> Google Sign-In is working with all 3 SHA-1s registered.

---

## 🔴 STEP 4 — Google Play Data Safety Declaration

**Where:** Play Console → Your App → Policy → Data Safety

Fill in exactly as follows:

| Data Type | Collected? | Shared? | Required? | Purpose |
|---|---|---|---|---|
| Name | Yes | No | No | Account management |
| Email address | Yes | No | Yes | Authentication |
| User IDs | Yes | No | Yes | Authentication |
| App interactions | Yes | No | No | Analytics (optional) |
| Crash logs | Yes | No | No | App performance (optional) |
| Device identifiers | Yes | No | No | App performance (optional) |

**Critical wording for Analytics row:**
- "User can choose whether this data is collected" → ✅ YES
- "Data is encrypted in transit" → ✅ YES
- "Users can request deletion" → ✅ YES (account delete wipes all data)

---

## 🟡 STEP 5 — Internal Testing Track (Before Production)

1. Build signed AAB: `flutter build appbundle --release`
2. Upload to Play Console → Internal Testing
3. Install on a REAL device (not emulator)
4. Verify these flows work end-to-end:
   - [ ] Google Sign-In succeeds
   - [ ] Analytics toggle works (off by default if first launch)
   - [ ] Create 20+ food logs, weight logs, activity logs
   - [ ] Delete account
   - [ ] Wait 5 minutes
   - [ ] Check Firestore Console: `users/{uid}` must be completely empty
   - [ ] Confirm Google account is gone from Firebase Auth console

---

## 🟢 STEP 6 — Production Upload

Only after ALL internal tests pass:
1. Add Play App Signing SHA-1 to Firebase (from Step 1C)
2. Enable App Check Enforcement on Firestore (from Step 3)
3. Submit for Google Play review

---

## Links
- Firebase Console: https://console.firebase.google.com/project/pakfittrack
- Privacy Policy: https://pakfittrack.web.app/privacy-policy.html
- Terms of Service: https://pakfittrack.web.app/terms-of-service.html
