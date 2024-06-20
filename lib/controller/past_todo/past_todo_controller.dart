import 'package:quick_flutter/controller/mixin/app_todo_items_notifer_mixin.dart';
import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/todo_span/todo_span_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'past_todo_controller.g.dart';

/// 昨日以降の[TodoItem]を取得するコントローラー
@Riverpod(keepAlive: true)
class PastTodoController extends _$PastTodoController
    with AppTodoItemsNotifierMixin {
  @override
  FutureOr<List<AppTodoItem>> build() async {
    ref.watch(refreshControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return [];
    }
    final repository = ref.read(appItemRepositoryProvider(user.value!.id));

    // todoSpanControlerProviderの数分前の日のTodoを取得する
    // 例: 3日前のTodoを取得する場合、3日前の0時から今日の0時までのTodoを取得する
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final span = ref.watch(todoSpanControllerProvider);
    final start = todayStart.subtract(Duration(days: span));
    final items = await repository.fetch(
      start: start,
      end: todayStart,
      isDone: false,
    );
    final todos = items.whereType<AppTodoItem>().toList();
    return todos;
  }
}
