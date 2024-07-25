import 'package:tokeru_desktop/controller/mixin/app_todo_items_notifer_mixin.dart';
import 'package:tokeru_desktop/controller/refresh/refresh_controller.dart';
import 'package:tokeru_desktop/controller/user/user_controller.dart';
import 'package:tokeru_desktop/model/app_item/app_item.dart';
import 'package:tokeru_desktop/repository/app_item/app_item_repository.dart';
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
    // streamをindex順に並び替える。
    return stream.map((event) {
      return event
        ..sort((a, b) {
          return a.index.compareTo(b.index);
        });
    });
  }
}
