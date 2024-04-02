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
    apiKey: 'AIzaSyCMTQaY-H44SwPOumzP-uwi8uYl9PQ91bU',
    appId: '1:1077323013776:web:745c75d212232887200215',
    messagingSenderId: '1077323013776',
    projectId: 'mad-project-21it087',
    authDomain: 'mad-project-21it087.firebaseapp.com',
    storageBucket: 'mad-project-21it087.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBIoY8HF4l8m9RgheURihQoRKTFvUzK5c',
    appId: '1:1077323013776:android:1cffc11f88b791b4200215',
    messagingSenderId: '1077323013776',
    projectId: 'mad-project-21it087',
    storageBucket: 'mad-project-21it087.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEiIzSk39kKvtDrhdN-cW5iQNRklQcqB8',
    appId: '1:1077323013776:ios:7e81632f4d5e52fc200215',
    messagingSenderId: '1077323013776',
    projectId: 'mad-project-21it087',
    storageBucket: 'mad-project-21it087.appspot.com',
    iosBundleId: 'com.example.project',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBEiIzSk39kKvtDrhdN-cW5iQNRklQcqB8',
    appId: '1:1077323013776:ios:8c78429e116b917c200215',
    messagingSenderId: '1077323013776',
    projectId: 'mad-project-21it087',
    storageBucket: 'mad-project-21it087.appspot.com',
    iosBundleId: 'com.example.project.RunnerTests',
  );
}