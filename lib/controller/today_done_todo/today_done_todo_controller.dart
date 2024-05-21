import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:quick_flutter/repository/todo/todo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'today_done_todo_controller.g.dart';

/// 今日の完了済みの[TodoItem]を取得するコントローラー
@riverpod
class TodayDoneTodoController extends _$TodayDoneTodoController {
  @override
  FutureOr<List<TodoItem>> build() async {
    ref.watch(refreshControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return [];
    }
    // DoneされていないTodo一覧が減っていたら再取得する
    ref.listen(todoControllerProvider, (pre, next) {
      if ((pre?.valueOrNull?.length ?? 0) > (next.valueOrNull?.length ?? 0)) {
        ref.invalidateSelf();
      }
    });
    final todoRepository = ref.read(todoRepositoryProvider(user.value!.id));

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final todos =
        await todoRepository.fetchTodosAfter(date: todayStart, isDone: true);
    return todos;
  }
}
