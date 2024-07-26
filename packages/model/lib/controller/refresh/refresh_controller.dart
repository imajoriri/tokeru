import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refresh_controller.g.dart';

/// アプリ内のデータを更新するためのコントローラー。
///
/// 「Cmd + R」でこのProviderがinvalidateされ、watchしているProviderも更新されることを
/// 想定している。
/// 最新更新日を返す。
/// このコントローラーをref.watchすることで、データの更新を行う。
@Riverpod(keepAlive: true)
class RefreshController extends _$RefreshController {
  @override
  DateTime build() {
    return DateTime.now();
  }
}
