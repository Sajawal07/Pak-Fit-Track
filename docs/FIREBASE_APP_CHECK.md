# Firebase App Check — enforcement

The app activates App Check in `lib/main.dart`:

- **Android:** Play Integrity (`AndroidProvider.playIntegrity`)
- **iOS:** Device Check (`AppleProvider.deviceCheck`)

## Enforce (required for production)

**Do this in Firebase Console — not in `firestore.rules`.**

Rule syntax for App Check tokens is easy to get wrong; Console enforcement is the recommended path.

1. Firebase Console → **App Check**
2. Register your Android app (`com.pakfittrack.app`) with **Play Integrity**
3. Register iOS with **Device Check** (or App Attest for production iOS)
4. Go to **App Check** → **Cloud Firestore** → **Enforce**
5. Monitor metrics for 1–2 days before blocking all traffic (use “Unenforced” first if offered)

## Before enforcement

- [ ] Release build installed from Play Internal testing **or** signed release APK with correct SHA keys
- [ ] `google-services.json` matches `com.pakfittrack.app`
- [ ] Firestore reads/writes work with enforcement **off**
- [ ] Turn enforcement **on** and retest sign-in, sync, delete account

## Debug builds

For local development with enforcement on, register **debug tokens**:

1. App Check → your app → **Manage debug tokens**
2. Run the app once; check logcat for App Check debug token
3. Add token in Console

## Current Firestore rules

`firestore.rules` uses auth-only checks (`request.auth.uid == userId`). App Check is enforced at the **service** layer via Console, not duplicated in rules.
