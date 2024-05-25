import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refresh_controller.g.dart';

/// データを更新するためのコントローラー。
///
/// 最新更新日を返す。
/// このコントローラーをref.watchすることで、データの更新を行う。
@Riverpod(keepAlive: true)
class RefreshController extends _$RefreshController {
  @override
  DateTime build() {
    return DateTime.now();
  }

  /// 更新が昨日以前のものかどうかを判定する
  bool isPast() {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    return state.isBefore(todayStart);
  }
}
