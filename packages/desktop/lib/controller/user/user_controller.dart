import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:tokeru_desktop/model/user/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_controller.g.dart';

/// ログインしているユーザーを取得する
///
/// Firebase authentication の匿名ログインを行い、ログインしているユーザーを取得します。
/// ログインしていない場合は匿名ログインを行います。
@Riverpod(keepAlive: true)
Future<User> userController(UserControllerRef ref) async {
  final instance = firebase_auth.FirebaseAuth.instance;
  final currentFirebaseUser = instance.currentUser;
  if (currentFirebaseUser != null) {
    return User(id: currentFirebaseUser.uid);
  }

  try {
    final userCredential = await instance.signInAnonymously();
    return User(id: userCredential.user!.uid);
  } on firebase_auth.FirebaseAuthException catch (e, s) {
    await FirebaseCrashlytics.instance.recordError(e, s);
    rethrow;
  }
}
