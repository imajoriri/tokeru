import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/analytics_event/analytics_event_name.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'new_todo.g.dart';

/// Todoを追加するIndexの指定方法。
enum TodoAddIndexType {
  /// 一番最初に追加する。
  first,

  /// 一番最後に追加する。
  last,

  /// 現在のフォーカスがあるTodoの次に追加する。
  ///
  /// 現在のフォーカスがない場合は、一番最後に追加する。
  current,
}

/// [AppTodoItem]の追加を行うController。
///
/// todos:
/// - index: [TodoController]に追加する位置
/// - title: 追加する[AppTodoItem]のタイトル
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
@riverpod
Future<AppTodoItem?> newTodo(
  NewTodoRef ref, {
  String title = '',
  required TodoAddIndexType indexType,
}) async {
  final user = ref.read(userControllerProvider);
  if (user.valueOrNull == null) {
    assert(false, 'user is null');
    return null;
  }

  // フォーカスを移動した時に2つのフォーカスが存在することがあるため、
  // 一度全てのフォーカスを外す。
  FocusManager.instance.primaryFocus?.unfocus();

  // 追加するTodoのIndex。
  final index = switch (indexType) {
    TodoAddIndexType.first => 0,
    TodoAddIndexType.last =>
      ref.read(todoControllerProvider).valueOrNull!.length,
    TodoAddIndexType.current =>
      ref.read(todoFocusControllerProvider.notifier).getFocusIndex() + 1,
  };
  final item = AppTodoItem(
    id: const Uuid().v4(),
    title: title,
    isDone: false,
    index: index,
    createdAt: DateTime.now(),
  );

  final repository = ref.read(appItemRepositoryProvider(user.value!.id));
  try {
    await repository.add(item);
  } on Exception catch (e, s) {
    await FirebaseCrashlytics.instance.recordError(e, s);
  }

  if (indexType == TodoAddIndexType.current) {
    // フォーカスが存在していると
    FocusManager.instance.primaryFocus?.unfocus();
    ref.read(todoFocusControllerProvider)[item.index].requestFocus();
  }

  FirebaseAnalytics.instance.logEvent(
    name: AnalyticsEventName.addTodo.name,
  );
  return item;
}
