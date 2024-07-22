import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_delete_controller.g.dart';

/// [AppTodoItem]の削除を行うController。
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
@riverpod
Future<void> todoDeleteController(
  TodoDeleteControllerRef ref, {
  required String todoId,
}) async {
  final user = ref.read(userControllerProvider);
  if (user.valueOrNull == null) {
    assert(false, 'user is null');
    return;
  }
  final repository = ref.read(appItemRepositoryProvider(user.value!.id));
  try {
    await repository.delete(id: todoId);
  } on Exception catch (e, s) {
    await FirebaseCrashlytics.instance.recordError(e, s);
  }

  // TodoControllerも更新する。
  ref.read(todoControllerProvider.notifier).deleteTodo(todoId: todoId);
}
