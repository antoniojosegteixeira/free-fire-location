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
    apiKey: 'AIzaSyCF2oavSzk39CjJSGMgI1naioNGjqWYFFA',
    appId: '1:459589203676:web:30a9575577258a98122619',
    messagingSenderId: '459589203676',
    projectId: 'freef-17df5',
    authDomain: 'freef-17df5.firebaseapp.com',
    storageBucket: 'freef-17df5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkIJls7O_k7TqdFC88c-9hc1HTkhfR5Wk',
    appId: '1:459589203676:android:1e90cf3468d20621122619',
    messagingSenderId: '459589203676',
    projectId: 'freef-17df5',
    storageBucket: 'freef-17df5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrwBCfcwoSSqL7Ht_Cs0UR91qwq5uvMfY',
    appId: '1:459589203676:ios:4091e073e7e596a4122619',
    messagingSenderId: '459589203676',
    projectId: 'freef-17df5',
    storageBucket: 'freef-17df5.appspot.com',
    iosClientId: '459589203676-injdn2b0ivc69ak5tfc1lncord5v4eg3.apps.googleusercontent.com',
    iosBundleId: 'com.example.freeFireLocation',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrwBCfcwoSSqL7Ht_Cs0UR91qwq5uvMfY',
    appId: '1:459589203676:ios:4091e073e7e596a4122619',
    messagingSenderId: '459589203676',
    projectId: 'freef-17df5',
    storageBucket: 'freef-17df5.appspot.com',
    iosClientId: '459589203676-injdn2b0ivc69ak5tfc1lncord5v4eg3.apps.googleusercontent.com',
    iosBundleId: 'com.example.freeFireLocation',
  );
}
