import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quick_flutter/controller/today_app_item/today_app_item_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo_add_controller.g.dart';

/// [AppTodoItem]を複数追加を行うController。
///
/// 複数の[Todo]を一度に追加するために、Recordを受け取っている。
///
/// todos:
/// - index: [TodoController]に追加する位置
/// - title: 追加する[AppTodoItem]のタイトル
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
@riverpod
Future<void> todoAddController(
  TodoAddControllerRef ref, {
  required List<
          ({
            int index,
            String title,
          })>
      todos,
}) async {
  final user = ref.read(userControllerProvider);
  if (user.valueOrNull == null) {
    assert(false, 'user is null');
    return;
  }
  final items = todos
      .map(
        (e) => AppTodoItem(
          id: const Uuid().v4(),
          title: e.title,
          isDone: false,
          index: e.index,
          createdAt: DateTime.now(),
        ),
      )
      .toList();
  final repository = ref.read(appItemRepositoryProvider(user.value!.id));

  try {
    await repository.addAll(items);
    for (final item in items) {
      ref.read(todayAppItemControllerProvider.notifier).addTodo(todo: item);
      ref.read(todoControllerProvider.notifier).addTodo(todo: item);
    }
  } on Exception catch (e, s) {
    await FirebaseCrashlytics.instance.recordError(e, s);
  }
}
