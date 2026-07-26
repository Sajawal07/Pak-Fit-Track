# Firebase “Delete User Data” extension (recommended)

Client-side deletion in the app can fail if the user loses network mid-loop. Google’s supported fix is the official extension — **do not** build a custom Cloud Function unless you have special needs.

## Install

1. [Firebase Console](https://console.firebase.google.com) → your project → **Extensions**
2. Install **Delete User Data** (`firebase/delete-user-data`)
3. When prompted, use the default Cloud Functions region near your users

## Configure paths to delete

Match what `SyncService` writes:

| Cloud Firestore path | Delete |
|----------------------|--------|
| `users/{UID}` | Yes (document) |
| `users/{UID}/food_logs/{DOCUMENT_ID}` | Yes |
| `users/{UID}/weight_logs/{DOCUMENT_ID}` | Yes |
| `users/{UID}/activity_logs/{DOCUMENT_ID}` | Yes |

Use recursive delete for subcollections if the extension UI offers it.

## Trigger

- **Auth user deleted** — enable “Delete on Auth user delete”
- The app calls `user.delete()` after wiping subcollections; the extension finishes any orphaned data server-side

## Relationship to the app

1. **In-app** (`AccountDeletionService`): deletes subcollections, verifies empty, deletes `users/{uid}`, deletes Auth user, clears Isar + SharedPreferences on device.
2. **Extension (backup)**: if step 1 fails partially, deleting the Auth user still triggers server-side cleanup.

## Test

1. Create test account, log sample data
2. Delete account in app
3. Firebase Console → Firestore → confirm `users/{testUid}` and subcollections are gone
4. Optional: delete Auth user only from Console and confirm extension runs
