import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'updated_todo.g.dart';

/// [AppTodoItem]の更新を行うController。
@riverpod
Future<AppTodoItem> updatedTodo(
  UpdatedTodoRef ref, {
  // NOTE: 本来はAppTodoItemを受け取るべきだが、生成されたコードは受け取れないため、AppItemに変更している。
  // https://github.com/rrousselGit/riverpod/issues/2273
  required AppItem todo,
}) async {
  if (todo is! AppTodoItem) {
    assert(false, 'todo is not AppTodoItem');
    throw Exception('todo is not AppTodoItem');
  }

  final user = ref.read(userControllerProvider);
  if (user.valueOrNull == null) {
    throw Exception('user is null');
  }

  final repository = ref.read(appItemRepositoryProvider(user.value!.id));
  try {
    repository.update(item: todo);
  } on Exception catch (e, s) {
    await FirebaseCrashlytics.instance.recordError(e, s);
  }

  return todo;
}
