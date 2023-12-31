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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDqpYW_WvxPNjyx32HLbyDIlXAyzwrvmBw',
    appId: '1:691213318665:web:c7569f7341edbdbe6356d8',
    messagingSenderId: '691213318665',
    projectId: 'application-ellocation',
    authDomain: 'application-ellocation.firebaseapp.com',
    storageBucket: 'application-ellocation.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuW8J0lvSEDi7u1J984LOrG1VjEyd5KPU',
    appId: '1:691213318665:android:fac5531d1ca230e16356d8',
    messagingSenderId: '691213318665',
    projectId: 'application-ellocation',
    storageBucket: 'application-ellocation.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaobud9fD26roI0nlJEaUwwTLTU0VI0Nk',
    appId: '1:691213318665:ios:1f96ffdd93146f056356d8',
    messagingSenderId: '691213318665',
    projectId: 'application-ellocation',
    storageBucket: 'application-ellocation.appspot.com',
    androidClientId:
        '691213318665-qcps7a7t6bqeam9d5u6inl02jrer6oa8.apps.googleusercontent.com',
    iosClientId:
        '691213318665-npbl76tm7nqismrc234re1v8028clb9d.apps.googleusercontent.com',
    iosBundleId: 'com.example.applicationEllocation',
  );
}
