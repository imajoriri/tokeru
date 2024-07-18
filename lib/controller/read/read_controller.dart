import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'read_controller.g.dart';

/// Todoの既読した時刻を管理するコントローラー。
@riverpod
class ReadController extends _$ReadController {
  @override
  FutureOr<DateTime> build() async {
    ref.watch(refreshControllerProvider);
    // 2時間前。
    return DateTime.now().subtract(const Duration(hours: 2));
  }
}
