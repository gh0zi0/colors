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
    apiKey: 'AIzaSyB2cj707yzZm2qhbToxLxcPquMDjjmt1Uw',
    appId: '1:952381607921:web:63889cd43f547679913e50',
    messagingSenderId: '952381607921',
    projectId: 'colors-62334',
    authDomain: 'colors-62334.firebaseapp.com',
    storageBucket: 'colors-62334.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBaJDBXQY9pjJsq96VDQpZMmk8egqJdQ6w',
    appId: '1:952381607921:android:3ed55b0d35c26a47913e50',
    messagingSenderId: '952381607921',
    projectId: 'colors-62334',
    storageBucket: 'colors-62334.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5nJHeUVVFHdZkTsoLLJazMwsgQNxkRAc',
    appId: '1:952381607921:ios:de6e303f42dcca1a913e50',
    messagingSenderId: '952381607921',
    projectId: 'colors-62334',
    storageBucket: 'colors-62334.appspot.com',
    iosClientId: '952381607921-il931cehv8mc8fn6g689a57v3o5sdk75.apps.googleusercontent.com',
    iosBundleId: 'com.example.colors',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD5nJHeUVVFHdZkTsoLLJazMwsgQNxkRAc',
    appId: '1:952381607921:ios:de6e303f42dcca1a913e50',
    messagingSenderId: '952381607921',
    projectId: 'colors-62334',
    storageBucket: 'colors-62334.appspot.com',
    iosClientId: '952381607921-il931cehv8mc8fn6g689a57v3o5sdk75.apps.googleusercontent.com',
    iosBundleId: 'com.example.colors',
  );
}
