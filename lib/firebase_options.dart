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
    apiKey: 'AIzaSyDDuV-uXWpYsH7I_0SgIGgi0mdY67Z1ELc',
    appId: '1:1017632833424:web:1228c476c089a69b3a7d15',
    messagingSenderId: '1017632833424',
    projectId: 'comeloso',
    authDomain: 'comeloso.firebaseapp.com',
    databaseURL: 'https://comeloso-default-rtdb.firebaseio.com',
    storageBucket: 'comeloso.appspot.com',
    measurementId: 'G-BRJ0JWNXTL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuZbtHrlfR5sdsh4ExhRGRt8L1jKd6vYc',
    appId: '1:1017632833424:android:33f001f36bb42de83a7d15',
    messagingSenderId: '1017632833424',
    projectId: 'comeloso',
    databaseURL: 'https://comeloso-default-rtdb.firebaseio.com',
    storageBucket: 'comeloso.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBS3es25mmlVtPRKpUw7VeLDTjwbMD5biY',
    appId: '1:1017632833424:ios:cb2cf25837071ea23a7d15',
    messagingSenderId: '1017632833424',
    projectId: 'comeloso',
    databaseURL: 'https://comeloso-default-rtdb.firebaseio.com',
    storageBucket: 'comeloso.appspot.com',
    iosClientId: '1017632833424-kd3hasep53fssbcgjf7p6kulkbuibl5t.apps.googleusercontent.com',
    iosBundleId: 'com.jose1060.comelosoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBS3es25mmlVtPRKpUw7VeLDTjwbMD5biY',
    appId: '1:1017632833424:ios:cb2cf25837071ea23a7d15',
    messagingSenderId: '1017632833424',
    projectId: 'comeloso',
    databaseURL: 'https://comeloso-default-rtdb.firebaseio.com',
    storageBucket: 'comeloso.appspot.com',
    iosClientId: '1017632833424-kd3hasep53fssbcgjf7p6kulkbuibl5t.apps.googleusercontent.com',
    iosBundleId: 'com.jose1060.comelosoApp',
  );
}
