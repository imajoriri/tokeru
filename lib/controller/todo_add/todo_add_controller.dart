import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quick_flutter/controller/today_app_item/today_app_item_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_add_controller.g.dart';

/// [AppTodoItem]の追加を行うController。
///
/// - index: [TodoController]に追加する位置
/// - title: 追加する[AppTodoItem]のタイトル
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
@riverpod
Future<void> todoAddController(
  TodoAddControllerRef ref, {
  required int index,
  required String title,
}) async {
  final user = ref.read(userControllerProvider);
  if (user.valueOrNull == null) {
    assert(false, 'user is null');
    return;
  }
  final repository = ref.read(appItemRepositoryProvider(user.value!.id));
  final todo = AppTodoItem(
    id: DateTime.now().toIso8601String(),
    title: title,
    isDone: false,
    index: index,
    createdAt: DateTime.now(),
  );
  try {
    await repository.add(todo);
    ref.read(todayAppItemControllerProvider.notifier).addTodo(todo: todo);
    ref.read(todoControllerProvider.notifier).addTodo(todo: todo, index: index);
  } on Exception catch (e, s) {
    await FirebaseCrashlytics.instance.recordError(e, s);
  }
}
