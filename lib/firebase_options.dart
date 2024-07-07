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
    apiKey: 'AIzaSyAcU_bgDQyeZSeblTBiAuxVpGITBR96IEg',
    appId: '1:428886898955:web:47a7e275ec2e7969630a0e',
    messagingSenderId: '428886898955',
    projectId: 'samyati-379318',
    authDomain: 'samyati-379318.firebaseapp.com',
    storageBucket: 'samyati-379318.appspot.com',
    measurementId: 'G-CM2JVVTQYG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIPEjYeAAfWCgrcJMZvydZQoodZFWkrSA',
    appId: '1:428886898955:android:7e24dad907f95ea3630a0e',
    messagingSenderId: '428886898955',
    projectId: 'samyati-379318',
    storageBucket: 'samyati-379318.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCbSPXYZB5ihmdv4GSjKx3pZ1yQUBLBLw',
    appId: '1:428886898955:ios:c76b3d37f38abbfb630a0e',
    messagingSenderId: '428886898955',
    projectId: 'samyati-379318',
    storageBucket: 'samyati-379318.appspot.com',
    androidClientId: '428886898955-r14k5nnpgvque647am0ooivfdikd16q9.apps.googleusercontent.com',
    iosClientId: '428886898955-vi5nmnhp0jq1ti6vnsot8nr90a6v041c.apps.googleusercontent.com',
    iosBundleId: 'com.example.samyati',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBCbSPXYZB5ihmdv4GSjKx3pZ1yQUBLBLw',
    appId: '1:428886898955:ios:c76b3d37f38abbfb630a0e',
    messagingSenderId: '428886898955',
    projectId: 'samyati-379318',
    storageBucket: 'samyati-379318.appspot.com',
    androidClientId: '428886898955-r14k5nnpgvque647am0ooivfdikd16q9.apps.googleusercontent.com',
    iosClientId: '428886898955-vi5nmnhp0jq1ti6vnsot8nr90a6v041c.apps.googleusercontent.com',
    iosBundleId: 'com.example.samyati',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAcU_bgDQyeZSeblTBiAuxVpGITBR96IEg',
    appId: '1:428886898955:web:a1c78a1bde0bdaaf630a0e',
    messagingSenderId: '428886898955',
    projectId: 'samyati-379318',
    authDomain: 'samyati-379318.firebaseapp.com',
    storageBucket: 'samyati-379318.appspot.com',
    measurementId: 'G-881HXYFJKQ',
  );
}
