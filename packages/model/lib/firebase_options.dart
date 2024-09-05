// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart'
    show Firebase, FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb, kReleaseMode;
import 'package:tokeru_model/systems/flavor.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    appleProvider: kReleaseMode ? AppleProvider.appAttest : AppleProvider.debug,
  );
}

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// await initializeFirebase();
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
        return flavorEnv == Flavor.prod.name ? prod : dev;
      case TargetPlatform.macOS:
        return flavorEnv == Flavor.prod.name ? prod : dev;
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

  static const FirebaseOptions dev = FirebaseOptions(
    apiKey: 'AIzaSyBASHnaNJ0ry00TlXoPeJVQAZkv2cd414w',
    appId: '1:998557904358:ios:26798c3f7837a6d617fa27',
    messagingSenderId: '998557904358',
    projectId: 'quick-chat-dev-a442c',
    storageBucket: 'quick-chat-dev-a442c.appspot.com',
    iosBundleId: 'com.tokeru.macos.dev',
  );

  static const FirebaseOptions prod = FirebaseOptions(
    apiKey: 'AIzaSyDlDMQe3k9nq3I9LTTEEO4xpBJogJyt5rY',
    appId: '1:93729662960:ios:730348869192c221f81f35',
    messagingSenderId: '93729662960',
    projectId: 'quick-chat-pro',
    storageBucket: 'quick-chat-pro.appspot.com',
    iosBundleId: 'com.tokeru.macos.prod',
  );
}
