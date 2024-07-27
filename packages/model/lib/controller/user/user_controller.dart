import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tokeru_model/model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_controller.g.dart';

/// ログインしているユーザーを取得する
///
/// Firebase authentication の匿名ログインを行い、ログインしているユーザーを取得します。
/// ログインしていない場合は匿名ログインを行います。
@Riverpod(keepAlive: true)
class UserController extends _$UserController {
  @override
  Future<User> build() async {
    final currentUser = auth.FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return User(
        id: currentUser.uid,
        idToken: await currentUser.getIdToken() ?? '',
        isAnonymous: currentUser.isAnonymous,
      );
    }

    try {
      final userCredential =
          await auth.FirebaseAuth.instance.signInAnonymously();
      return User(
        id: userCredential.user!.uid,
        idToken: await userCredential.user!.getIdToken() ?? '',
        isAnonymous: true,
      );
    } on auth.FirebaseAuthException catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
      rethrow;
    }
  }

  /// Google アカウントでログインする。
  Future<void> signInWithGoogle() async {
    const clientId = String.fromEnvironment('google_client_id');
    if (clientId.isEmpty) {
      throw Exception('Google client id is not set.');
    }

    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(clientId: clientId).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // acceccTokenとidTokenがない場合はキャンセルとみなして処理を終了する
    if (googleAuth?.accessToken == null || googleAuth?.idToken == null) {
      return;
    }

    // Create a new credential
    final credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      await auth.FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);
    } on auth.FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          Exception("The provider has already been linked to the user.");
          break;
        case "invalid-credential":
          Exception("The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          Exception(
              "The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.");
          break;
        // See the API reference for the full list of error codes.
        default:
          Exception("Unknown error.");
      }
    } finally {
      // すでにログイン済みのユーザーの場合、`linkWithCredential`でエラーになる。
      // その場合は、`signInWithCredential`でログインする。
      await auth.FirebaseAuth.instance.signInWithCredential(credential);
      ref.invalidateSelf();
    }
  }

  /// サインアウトする。
  Future<void> signOut() async {
    await auth.FirebaseAuth.instance.signOut();
    const clientId = String.fromEnvironment('google_client_id');
    if (clientId.isEmpty) {
      throw Exception('Google client id is not set.');
    }

    await GoogleSignIn(clientId: clientId).signOut();
    ref.invalidateSelf();
  }
}
