import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_sign_in_controller.g.dart';
part 'google_sign_in_controller.freezed.dart';

@freezed
class GoogleSignInState with _$GoogleSignInState {
  /// Googleサインインの状態を表す。
  ///
  /// [isSignIn]がtrueの場合、ログイン済み。
  /// [client]にはログイン情報が格納される。
  const factory GoogleSignInState({
    required bool isSignIn,
    AuthClient? client,
  }) = _GoogleSignInState;
}

/// [GoogleSignIn]を取得するためのコントローラー。
///
/// 呼び出しと同時に[GoogleSignIn.signInSilently]を実行し、
/// すでにログイン済みの場合はその情報を取得する。
@riverpod
class GoogleSignInController extends _$GoogleSignInController {
  @override
  FutureOr<GoogleSignInState> build() async {
    final googleSignIn = GoogleSignIn(
      clientId:
          // TODO: 環境変数に置き換える?
          '288995585248-jg8691tt5gi3bas6ibkdaql6q7sq2o8m.apps.googleusercontent.com',
      scopes: [
        CalendarApi.calendarEventsReadonlyScope,
        CalendarApi.calendarReadonlyScope,
      ],
    );
    await googleSignIn.signInSilently();
    final isSignIn = await googleSignIn.isSignedIn();
    return GoogleSignInState(
      isSignIn: isSignIn,
      client: await googleSignIn.authenticatedClient(),
    );
  }
}
