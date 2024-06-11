import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/today_app_item/today_app_item_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'today_done_todo_controller.g.dart';

/// 今日作成された完了済みの[AppTodoItem]を返すController
///
/// [todayAppItemControllerProvider]を監視すしているため、[todayAppItemControllerProvider]が更新されると、
/// このControllerも更新される。
@Riverpod(keepAlive: true)
class TodayDoneTodoController extends _$TodayDoneTodoController {
  @override
  FutureOr<List<AppTodoItem>> build() async {
    ref.watch(refreshControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return [];
    }

    // todoControllerを監視する。
    ref.watch(todoControllerProvider);

    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final appItems = await repository.fetch(
      start: todayStart,
      type: 'todo',
      isDone: true,
    );
    final todos = appItems.whereType<AppTodoItem>().toList();
    return todos;
  }
}
