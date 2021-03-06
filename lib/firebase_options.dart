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
    apiKey: 'AIzaSyCbZfstPjuFQoQKpwPZThc9CZ6_G32LlAg',
    appId: '1:714473791743:web:4e812b94f0775b7c616cca',
    messagingSenderId: '714473791743',
    projectId: 'ninja-brew-crew-a83b7',
    authDomain: 'ninja-brew-crew-a83b7.firebaseapp.com',
    storageBucket: 'ninja-brew-crew-a83b7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHfHrgX_LYkWo-HenZf1r1YdRJkQcf_pc',
    appId: '1:714473791743:android:bc18625c6f24f820616cca',
    messagingSenderId: '714473791743',
    projectId: 'ninja-brew-crew-a83b7',
    storageBucket: 'ninja-brew-crew-a83b7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD33g9-VZrAZDKPZe0qRdVexUxgB7Jqj8Q',
    appId: '1:714473791743:ios:2714f78d6bb1418b616cca',
    messagingSenderId: '714473791743',
    projectId: 'ninja-brew-crew-a83b7',
    storageBucket: 'ninja-brew-crew-a83b7.appspot.com',
    iosClientId: '714473791743-pvnve3jjkvqngg4dsnm8a07fqpgdtlb1.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebase1',
  );
}
