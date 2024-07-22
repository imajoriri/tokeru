import 'package:quick_flutter/controller/mixin/app_todo_items_notifer_mixin.dart';
import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_controller.g.dart';

/// 未完了の[AppTodoItem]を返すController。
///
/// ユーザーがログインしていない場合は空を返す。
@Riverpod(keepAlive: true)
class TodoController extends _$TodoController with AppTodoItemsNotifierMixin {
  @override
  Stream<List<AppTodoItem>> build() {
    ref.watch(refreshControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return const Stream.empty();
    }
    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    final stream = repository.fetchTodos(
      isDone: false,
    );
    stream.listen((event) {
      // print(event);
    });
    return stream;
  }
}
