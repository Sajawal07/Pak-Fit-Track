# Account Deletion — Admin Runbook (Manual Processing)

This document is the **step-by-step procedure for manually processing account
deletion requests** for the Pak Fit Track app (`com.pakfittrack.app`,
Firebase project `pakfittrack`).

> **Status note:** These console/CLI procedures are written from the actual
> app data model and Firestore rules in this repository. They have **not**
> been executed against the live production project as part of writing this
> document — process the first real request carefully and note any Firebase
> console UI differences you encounter.

## 1. Architecture overview

The app runs on the **Firebase Spark (free) plan** and does **not** use
Cloud Functions, the Firebase Admin SDK from a server, or any automated
deletion pipeline. The client app **never** calls `user.delete()`.

The flow is:

1. The user submits a deletion request from the app
   (**Profile → Settings → Delete account**) or by email.
2. For in-app requests, the client re-authenticates the user, then writes a
   `deletionRequests/{uid}` document (`status: "pending"`) to Firestore.
3. The client stops cloud sync, clears the user's **local** device data
   (Isar records, step history, app settings, notifications), and signs the
   user out. **Nothing in the cloud is deleted at this point.**
4. **You (the administrator)** manually delete the cloud data and the
   Firebase Authentication account using the steps below.

Email-based requests (from users who cannot access the app) skip step 2–3
and are processed with the same backend steps; see §2.1.

### Products NOT involved (nothing to clean up there)

| Product | Status |
|---|---|
| Firebase Cloud Functions | Not used |
| Firebase Storage | Not used (no dependency in the app) |
| Firebase Realtime Database | Not used |
| Firebase Cloud Messaging | Not used |
| `arena_leaderboard` Firestore collection | Referenced in security rules only — the app never reads/writes it |
| Firebase Analytics events | Not deletable per-user — see §9 |

## 2. Find and validate the pending request

### 2.1 In-app requests

1. Open **Firebase Console → project `pakfittrack` → Firestore Database →
   `deletionRequests` collection**.
2. Find the document whose ID is the user's UID and whose `status` is
   `"pending"`. Fields:
   ```json
   {
     "uid": "<firebase_uid>",
     "email": "<user_email>",
     "requestedAt": "<server timestamp>",
     "status": "pending"
   }
   ```
3. Validate **before deleting anything**:
   - The document ID equals the `uid` field (they must match).
   - The `email` matches a user in **Authentication → Users** for that UID.
   - The request looks consistent (no duplicate/conflicting requests).

### 2.2 Email requests (no in-app document)

1. The user emails **Sajawal0005@gmail.com** from their registered address
   with the subject "Account deletion request".
2. Look up the account: **Authentication → Users → search by the sender's
   email** → copy the **UID**.
3. If the sender cannot be verified as the account owner (e.g., a different
   email address), **reply asking for confirmation from the registered
   address and do not delete anything** until ownership is verified.

### 2.3 Anti-abuse check

Only process a request that comes from (a) the app while signed in as that
user, or (b) the account's own registered email address. Never delete an
account because a third party asked for it.

## 3. Capture the exact UID

Copy the UID from the validated request (or from Authentication search) into
your working notes. **Every deletion command in the next steps must use this
exact UID.** Double-check each character — deleting the wrong UID destroys
another user's data permanently.

## 4. Delete the user's Firestore data (recursive)

> **CRITICAL:** Deleting the parent document `users/{uid}` does **NOT**
> delete its subcollections. Firestore subcollections survive parent
> deletion. You must delete every subcollection document explicitly.

The complete cloud data model for one user:

```
users/{uid}                        ← profile document
users/{uid}/food_logs/{docId}      ← subcollection
users/{uid}/weight_logs/{docId}    ← subcollection
users/{uid}/activity_logs/{docId}  ← subcollection
deletionRequests/{uid}             ← deletion request (handled in §6)
```

### Option A — Firebase CLI (recommended, truly recursive)

```bash
firebase firestore:delete --recursive --project pakfittrack users/<UID>
```

This deletes the profile document **and** all of `food_logs`,
`weight_logs`, and `activity_logs`. Verify it prints a deleted-document
count greater than zero.

> There is **no** `firebase firestore:delete --uid` command — always use the
> full `users/<UID>` path with `--recursive`.

### Option B — Firebase Console (manual, no CLI)

Deleting `users/{uid}` in the console removes only the parent document.
You must also delete every document in each subcollection:

1. Open `users/{uid}` → expand **each** subcollection
   (`food_logs`, `weight_logs`, `activity_logs`).
2. Delete **every document** in each subcollection (select → Delete; repeat
   until each subcollection is empty).
3. Delete the parent `users/{uid}` document itself.
4. Re-open `users/{uid}` to confirm the subcollections are gone/empty —
   if any document remains, deletion is **not** complete.

## 5. Delete the Firebase Authentication account

1. Open **Firebase Console → Authentication → Users**.
2. Search for the UID (or the account's email address).
3. Confirm the result shows the **same UID** you captured in §3.
4. Click the three-dot menu on that row → **Delete** → confirm.

After this, the account can no longer sign in with email/password or with
Google Sign-In (the Firebase Auth user is gone; Google Sign-In would create
a *new* empty account on next sign-in — see §8).

> Deleting the Firebase Auth user does **not** delete the user's Google
> account or any data Google holds.

## 6. Handle the deletion-request document

After (and only after) §4 and §5 are verified:

- **Default:** delete `deletionRequests/{uid}` in the console.
- **If you need an audit trail** (e.g., legal/compliance record that a
  request was received and completed): instead of deleting, edit the
  document and set `status` to `"completed"` **and remove the `email`
  field** so no personal data is retained beyond necessity. Keep it only as
  long as genuinely required, then delete it.

> Note: the app's security rules deliberately forbid the *user* from
  updating or deleting their request document — only an administrator
  (console/CLI, which bypasses rules) can do this.

## 7. Verify the result

Verify **all** of the following before telling anyone the request is done:

1. **Authentication → Users**: searching for the account's email or UID
   returns **no user**.
2. **Firestore**: `users/{uid}` does not exist.
3. **Firestore**: `users/{uid}/food_logs`, `users/{uid}/weight_logs`, and
   `users/{uid}/activity_logs` contain **no documents** (if the console
   still shows them after a CLI `--recursive` delete, re-check by
   refreshing; for Option B, re-open each subcollection).
4. **Firestore**: `deletionRequests/{uid}` is deleted, or (audit variant)
   has `status: "completed"` and no `email` field.
5. **Sign-in test** (optional but recommended): attempt to sign in on a
   test device with the old credentials — email/password must fail with
   "no account found". Google Sign-In must land in onboarding as a brand
   new, **empty** account (no profile, no logs) — if old data appears, §4
   was not completed.

## 8. Special cases and partial failures

Process the steps in order §4 → §5 → §6. If a step fails midway, the
account is in a **partial state** — finish the remaining steps; every step
is safe to re-run:

| Partial state | What to do |
|---|---|
| Firestore data deleted, Auth user still exists | Continue with §5, then §6 |
| Auth user deleted, Firestore data still exists | Continue with §4 (console/CLI work without the Auth user), then §6 |
| User signs back in with Google before you finish | Google Sign-In creates a **new** UID with empty data — the old UID's data is what you must still delete (§4). The new account is unaffected. |
| Console/CLI network error mid-delete | Retry the same command; deletes are idempotent (deleting a non-existent document is a no-op) |
| `deletionRequests` document forgotten | Always finish with §6 — never leave the request doc with a live email address after completion |

**Never** use `firebase firestore:delete --all-collections` — that destroys
every user's data.

## 9. Data that cannot be deleted through the console (documented limits)

- **Firebase Analytics events** — the app never links events to the user ID
  (no `setUserId` call), so events are anonymised app-usage records and
  **cannot be deleted per-user**. They age out under Google Analytics'
  retention settings. This limitation is disclosed in the privacy policy.
- **Data on the user's other devices** — the app cannot remotely wipe other
  phones. After the Auth user is deleted, those sessions can no longer
  sync; the user must uninstall the app or clear its data per device.
- **Health Connect (step) data** — lives in the device's health store; the
  app is read-only there. The user manages it via Android settings.
- **The user's Google account / Google-held data** — out of scope.
- **Scheduled exports/backups, if any** — not expected on the Spark plan,
  but if the project ever has scheduled Firestore exports or backups
  configured (Google Cloud Console → Firestore → Import/Export), those
  exports contain user data and must also be purged or allowed to expire.
  Verify whether any exist before considering a request fully complete for
  legal purposes.

## 10. Record completion (minimal personal data)

Keep a short processing log entry containing only:

- Date the request was processed
- The UID (personal data itself — store it in the same secured place as the
  Firebase console access, not in casual spreadsheets/chat)
- Steps completed (§4 / §5 / §6) and verification result (§7)

Do **not** copy the user's email or profile contents into notes, tickets, or
chat logs. If the user emailed their request, reply to their thread to
confirm completion — that email thread is the natural audit record.

## 11. What the app does on its own (no admin action needed)

When the user submits the request **in the app**, immediately and locally:

- The `deletionRequests/{uid}` document is created (rules: create-only,
  owner-only, immutable for users).
- Cloud sync for the session is stopped.
- Local data for that UID is cleared: Isar profile/food/weight/activity/
  water logs and notification history, sync-queue items for those records,
  the user-specific SharedPreferences keys, local step history (native
  Room store + step preferences), and shown/scheduled notifications.
- The user is signed out.

This local cleanup only affects the device where the request was submitted.
It does **not** replace steps §4–§6.

## Quick reference

| # | Action | Where |
|---|--------|--------|
| 1 | Find + validate request | Firestore → `deletionRequests` (or email thread) |
| 2 | Capture exact UID | From the request document / Auth search |
| 3 | Delete user data recursively | `firebase firestore:delete --recursive --project pakfittrack users/<UID>` (or console: every subcollection doc + parent) |
| 4 | Delete Auth user | Console → Authentication → Users → Delete |
| 5 | Remove/retire request doc | Firestore → `deletionRequests/<UID>` |
| 6 | Verify | §7 checklist (Auth gone, all paths empty, sign-in fails) |
| 7 | Log completion minimally | §10 |
