// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:quick_flutter/systems/flavor.dart';

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
    const flavorEnv = String.fromEnvironment('flavor');
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        return flavorEnv == Flavor.prod.name ? macosProd : macosDev;
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

  static const FirebaseOptions macosDev = FirebaseOptions(
    apiKey: 'AIzaSyBASHnaNJ0ry00TlXoPeJVQAZkv2cd414w',
    appId: '1:998557904358:ios:214b952a04fa28e417fa27',
    messagingSenderId: '998557904358',
    projectId: 'quick-chat-dev-a442c',
    storageBucket: 'quick-chat-dev-a442c.appspot.com',
    iosBundleId: 'com.example.quickFlutter.dev',
  );

  static const FirebaseOptions macosProd = FirebaseOptions(
    apiKey: 'AIzaSyDlDMQe3k9nq3I9LTTEEO4xpBJogJyt5rY',
    appId: '1:93729662960:ios:ad17b70c1e190213f81f35',
    messagingSenderId: '93729662960',
    projectId: 'quick-chat-pro',
    storageBucket: 'quick-chat-pro.appspot.com',
    iosBundleId: 'com.example.quickFlutter.prod',
  );
}
