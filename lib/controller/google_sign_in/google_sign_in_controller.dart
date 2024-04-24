import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_sign_in_controller.g.dart';

/// [GoogleSignIn]を取得するためのコントローラー。
///
/// 呼び出しと同時に[GoogleSignIn.signInSilently]を実行し、
/// すでにログイン済みの場合はその情報を取得する。
@riverpod
class GoogleSignInController extends _$GoogleSignInController {
  @override
  FutureOr<GoogleSignIn> build() async {
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
    return googleSignIn;
  }
}
