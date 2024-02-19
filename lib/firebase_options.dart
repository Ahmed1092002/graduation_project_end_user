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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBKRCGpQc4FISQtcJ4hRFQ2CQfBOoIqL7g',
    appId: '1:323139323227:web:b86d7d02cee647bae8867e',
    messagingSenderId: '323139323227',
    projectId: 'refugee-d38eb',
    authDomain: 'refugee-d38eb.firebaseapp.com',
    storageBucket: 'refugee-d38eb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCA_MGPRfagMsUcJNdRtgL0XNfHgEQfnBA',
    appId: '1:323139323227:android:3cfd8c5f1e6145efe8867e',
    messagingSenderId: '323139323227',
    projectId: 'refugee-d38eb',
    storageBucket: 'refugee-d38eb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWcW2zUB2RZOYUypvt9KIVQAS5qdXCVaM',
    appId: '1:323139323227:ios:236d44a4c430adfde8867e',
    messagingSenderId: '323139323227',
    projectId: 'refugee-d38eb',
    storageBucket: 'refugee-d38eb.appspot.com',
    iosBundleId: 'com.example.graduationProjectEndUser',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDWcW2zUB2RZOYUypvt9KIVQAS5qdXCVaM',
    appId: '1:323139323227:ios:00af856396edf0bce8867e',
    messagingSenderId: '323139323227',
    projectId: 'refugee-d38eb',
    storageBucket: 'refugee-d38eb.appspot.com',
    iosBundleId: 'com.example.graduationProjectEndUser.RunnerTests',
  );
}
