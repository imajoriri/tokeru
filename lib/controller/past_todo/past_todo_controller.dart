import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'past_todo_controller.g.dart';

/// 昨日以降の[TodoItem]を取得するコントローラー
@riverpod
class PastTodoController extends _$PastTodoController {
  @override
  FutureOr<List<AppItem>> build() async {
    ref.watch(refreshControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return [];
    }
    final repository = ref.read(appItemRepositoryProvider(user.value!.id));

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final items = await repository.fetch(
      end: todayStart,
      isDone: false,
    );
    final todos = items.whereType<AppTodoItem>().toList();
    return todos;
  }
}
