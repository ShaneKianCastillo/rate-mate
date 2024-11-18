// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import  'package:firebase_core/firebase_core.dart' show FirebaseOptions;
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
    apiKey: 'AIzaSyAOlnZppxqpfPY1wQJAHua-Pl13XJx7RT4',
    appId: '1:18305303727:web:85057cc78a3a94f106405a',
    messagingSenderId: '18305303727',
    projectId: 'ratemate-20be0',
    authDomain: 'ratemate-20be0.firebaseapp.com',
    storageBucket: 'ratemate-20be0.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDRt4dXnpfbS4R9a1LGP663GbylSI7jGto',
    appId: '1:18305303727:android:4e68c21aa656c01706405a',
    messagingSenderId: '18305303727',
    projectId: 'ratemate-20be0',
    storageBucket: 'ratemate-20be0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBT9e1Nslyn0NlXODJpGDg_nztdmIk9XFU',
    appId: '1:18305303727:ios:a7a7f73aa9672aae06405a',
    messagingSenderId: '18305303727',
    projectId: 'ratemate-20be0',
    storageBucket: 'ratemate-20be0.firebasestorage.app',
    iosBundleId: 'com.example.projects',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBT9e1Nslyn0NlXODJpGDg_nztdmIk9XFU',
    appId: '1:18305303727:ios:a7a7f73aa9672aae06405a',
    messagingSenderId: '18305303727',
    projectId: 'ratemate-20be0',
    storageBucket: 'ratemate-20be0.firebasestorage.app',
    iosBundleId: 'com.example.projects',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAOlnZppxqpfPY1wQJAHua-Pl13XJx7RT4',
    appId: '1:18305303727:web:e3bfc9d2b3e3caf306405a',
    messagingSenderId: '18305303727',
    projectId: 'ratemate-20be0',
    authDomain: 'ratemate-20be0.firebaseapp.com',
    storageBucket: 'ratemate-20be0.firebasestorage.app',
  );
}
