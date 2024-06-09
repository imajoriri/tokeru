import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:quick_flutter/repository/todo/todo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'today_done_todo_controller.g.dart';

/// 今日作成された完了済みの[TodoItem]を返すController
@Riverpod(keepAlive: true)
class TodayDoneTodoController extends _$TodayDoneTodoController {
  @override
  FutureOr<List<TodoItem>> build() async {
    ref.watch(refreshControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return [];
    }

    // todoControllerを監視する。
    ref.watch(todoControllerProvider);

    final todoRepository = ref.read(todoRepositoryProvider(user.value!.id));

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    final todos = await todoRepository.fetchTodosAfter(
      date: todayStart,
      isDone: true,
    );
    // index順に並び替える
    todos.sort((a, b) => a.index.compareTo(b.index));
    return todos;
  }
}
