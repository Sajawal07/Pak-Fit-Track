// File generated manually based on Firebase console project apps settings.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAcH2iKLdOMmECJld8CZ8cN0FAoOy-vbAs',
    appId: '1:468407198380:web:1acb6e19340b181d2cb509',
    messagingSenderId: '468407198380',
    projectId: 'pakfittrack',
    authDomain: 'pakfittrack.firebaseapp.com',
    storageBucket: 'pakfittrack.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgo6pvd3fhm5VeFHZOIy7tBVhgO1rN9WM',
    appId: '1:468407198380:android:e4878156795f94e92cb509',
    messagingSenderId: '468407198380',
    projectId: 'pakfittrack',
    storageBucket: 'pakfittrack.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdAh2FO1n69FWb6QZ6OFurgdUPUdwJTNE',
    appId: '1:468407198380:ios:d9e132516b30fa662cb509',
    messagingSenderId: '468407198380',
    projectId: 'pakfittrack',
    storageBucket: 'pakfittrack.firebasestorage.app',
    iosBundleId: 'com.pakfittrack.app',
  );
}
