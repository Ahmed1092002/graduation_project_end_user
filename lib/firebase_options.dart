// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyCdFa1SM0D8Z3qw4Rh_AcCok7GsgvmUc40',
    appId: '1:457416420906:web:86c700fd3b96b28a371d53',
    messagingSenderId: '457416420906',
    projectId: 'newjop-1e222',
    authDomain: 'newjop-1e222.firebaseapp.com',
    storageBucket: 'newjop-1e222.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBPGpMPisf55HAcReMQN_u9qEtFJ5qWoA',
    appId: '1:457416420906:android:83ef69e1fef4aa78371d53',
    messagingSenderId: '457416420906',
    projectId: 'newjop-1e222',
    storageBucket: 'newjop-1e222.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-e9C2tnEUGhYNkj6y9GtZo5yybmMgQyU',
    appId: '1:457416420906:ios:4c83e7032d0ce9c9371d53',
    messagingSenderId: '457416420906',
    projectId: 'newjop-1e222',
    storageBucket: 'newjop-1e222.appspot.com',
    iosBundleId: 'com.example.graduationProjectEndUser',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-e9C2tnEUGhYNkj6y9GtZo5yybmMgQyU',
    appId: '1:457416420906:ios:4c83e7032d0ce9c9371d53',
    messagingSenderId: '457416420906',
    projectId: 'newjop-1e222',
    storageBucket: 'newjop-1e222.appspot.com',
    iosBundleId: 'com.example.graduationProjectEndUser',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCdFa1SM0D8Z3qw4Rh_AcCok7GsgvmUc40',
    appId: '1:457416420906:web:9997284e99dfa81a371d53',
    messagingSenderId: '457416420906',
    projectId: 'newjop-1e222',
    authDomain: 'newjop-1e222.firebaseapp.com',
    storageBucket: 'newjop-1e222.appspot.com',
  );

}