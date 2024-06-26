import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quick_flutter/controller/past_todo/past_todo_controller.dart';
import 'package:quick_flutter/controller/today_app_item/today_app_item_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_update_controller.g.dart';

/// [AppTodoItem]の更新を行うController。
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
@riverpod
Future<void> todoUpdateController(
  TodoUpdateControllerRef ref, {
  // NOTE: 本来はAppTodoItemを受け取るべきだが、生成されたコードは受け取れないため、AppItemに変更している。
  // https://github.com/rrousselGit/riverpod/issues/2273
  required AppItem todo,
}) async {
  if (todo is! AppTodoItem) {
    assert(false, 'todo is not AppTodoItem');
    return;
  }

  // 以下のエラーの対策
  // Providers are not allowed to modify other providers during their initialization.
  await ref.read(todayAppItemControllerProvider.future);
  await ref.read(todoControllerProvider.future);
  await ref.read(pastTodoControllerProvider.future);

  // TodayAppItemControllerも更新する。
  ref.read(todayAppItemControllerProvider.notifier).updateTodo(todo: todo);

  // TodoControllerも更新する。
  ref.read(todoControllerProvider.notifier).updateTodo(todo: todo);

  // PastTodoControllerも更新する。
  ref.read(pastTodoControllerProvider.notifier).updateTodo(todo: todo);

  final user = ref.read(userControllerProvider);
  if (user.valueOrNull == null) {
    assert(false, 'user is null');
    return;
  }
  final repository = ref.read(appItemRepositoryProvider(user.value!.id));
  try {
    await repository.update(item: todo);
  } on Exception catch (e, s) {
    await FirebaseCrashlytics.instance.recordError(e, s);
  }
}
