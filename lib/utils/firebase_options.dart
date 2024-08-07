// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
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
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB4wYCPsr5ab3_2h_gBCuF4C3S3meSmXVk',
    appId: '1:892413213063:web:52d137e4f48cf3ebb0bb22',
    messagingSenderId: '892413213063',
    projectId: 'chatify-97921',
    authDomain: 'chatify-97921.firebaseapp.com',
    storageBucket: 'chatify-97921.appspot.com',
    measurementId: 'G-5KBVNRQ9H3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAF4F8_iudwO7WviH3LfyrvcseTb7OZWnU',
    appId: '1:892413213063:android:9b09773a86f1256bb0bb22',
    messagingSenderId: '892413213063',
    projectId: 'chatify-97921',
    storageBucket: 'chatify-97921.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwlvrvg3XrOr2RQmJv_UzPNhG9j180eH0',
    appId: '1:892413213063:ios:fcd72e2b397e8dcdb0bb22',
    messagingSenderId: '892413213063',
    projectId: 'chatify-97921',
    storageBucket: 'chatify-97921.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwlvrvg3XrOr2RQmJv_UzPNhG9j180eH0',
    appId: '1:892413213063:ios:fcd72e2b397e8dcdb0bb22',
    messagingSenderId: '892413213063',
    projectId: 'chatify-97921',
    storageBucket: 'chatify-97921.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB4wYCPsr5ab3_2h_gBCuF4C3S3meSmXVk',
    appId: '1:892413213063:web:ae77a56d9edb3c09b0bb22',
    messagingSenderId: '892413213063',
    projectId: 'chatify-97921',
    authDomain: 'chatify-97921.firebaseapp.com',
    storageBucket: 'chatify-97921.appspot.com',
    measurementId: 'G-RRH32851QH',
  );
}
