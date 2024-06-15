import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quick_flutter/controller/mixin/app_todo_items_notifer_mixin.dart';
import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/today_app_item/today_app_item_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_controller.g.dart';

/// 今日作成された[AppTodoItem]を返すController
///
/// ユーザーがログインしていない場合は空を返す。
@Riverpod(keepAlive: true)
class TodoController extends _$TodoController with AppTodoItemsNotifierMixin {
  @override
  FutureOr<List<AppTodoItem>> build() async {
    ref.watch(refreshControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return [];
    }

    ref.listen(todayAppItemControllerProvider, (previous, next) {
      // [AppTodoItem]の数が変わった場合は再取得する。
      final previousTodo =
          previous?.valueOrNull?.whereType<AppTodoItem>().toList();
      final nextTodo = next.valueOrNull?.whereType<AppTodoItem>().toList();
      if (previousTodo?.length != nextTodo?.length) {
        ref.invalidateSelf();
      }
    });

    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final appItems = await repository.fetch(
      start: todayStart,
      type: 'todo',
      isDone: false,
    );
    final todos = appItems.whereType<AppTodoItem>().toList();
    // sort
    todos.sort((a, b) => a.index.compareTo(b.index));
    return todos;
  }

  /// [AppTodoItem]を追加する
  Future<void> add(
    int index, {
    String title = '',
  }) async {
    final user = ref.read(userControllerProvider);
    if (user.valueOrNull == null) {
      assert(false, 'user is null');
      return;
    }
    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    try {
      final todo = await repository.addTodo(
        createdAt: DateTime.now(),
        index: index,
        title: title,
      );
      final tmp = [...state.value!];
      tmp.insert(index, todo);
      state = AsyncData(tmp);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
