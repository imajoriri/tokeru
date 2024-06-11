import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_controller.g.dart';

/// 今日作成された[AppTodoItem]を返すController
///
/// ユーザーがログインしていない場合は空を返す。
@Riverpod(keepAlive: true)
class TodoController extends _$TodoController {
  Timer? _deleteDonesDebounce;
  Timer? _updateOrderDebounce;

  @override
  FutureOr<List<AppTodoItem>> build() async {
    ref.watch(refreshControllerProvider);
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return [];
    }
    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final appItems = await repository.fetch(
      start: todayStart,
      type: 'todo',
      isDone: false,
    );
    final todos = appItems.whereType<AppTodoItem>().toList();
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

  /// [AppTodoItem]を削除する
  Future<void> delete(AppItem todo) async {
    final user = ref.read(userControllerProvider);
    if (user.valueOrNull == null) {
      assert(false, 'user is null');
      return;
    }
    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    try {
      repository.delete(id: todo.id);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    final tmp = [...state.value!];
    tmp.removeWhere((element) => element.id == todo.id);
    state = AsyncData(tmp);
  }

  /// [todoId]に一致する[AppTodoItem.title]を更新する
  Future<void> updateTodoTitle({
    required String todoId,
    required String title,
  }) async {
    final index = state.valueOrNull!.indexWhere((e) => e.id == todoId);
    final todo = (state.valueOrNull![index]).copyWith(title: title);

    final user = ref.read(userControllerProvider);
    if (user.valueOrNull == null) {
      assert(false, 'user is null');
      return;
    }
    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    try {
      await repository.update(
        id: todo.id,
        title: todo.title,
      );
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    final tmp = [...state.value!];
    // ショートカットのソートと被り、最初に取得したindexと変わっている場合があるので
    // ここで再度indexを取得する
    final newindex = state.valueOrNull!.indexWhere((e) => e.id == todoId);
    tmp[newindex] = todo;
    state = AsyncData(tmp);
  }

  /// [AppTodoItem]のisDoneを更新し、リストから削除する。
  ///
  /// - [todoId]: 更新する[AppTodoItem]のID
  /// - [isDone]: 更新するisDoneの値
  /// - [milliseconds]: デバウンスする時間。この時間内に複数回呼ばれた場合、最後の呼び出しのみが実行される。
  /// - [onUpdated]: 更新後に実行するコールバック。
  Future<void> updateIsDone({
    required String todoId,
    bool isDone = true,
    int milliseconds = 1200,
    VoidCallback? onUpdated,
  }) async {
    final user = ref.read(userControllerProvider);
    if (user.valueOrNull == null) {
      assert(false, 'user is null');
      return;
    }
    final repository = ref.read(appItemRepositoryProvider(user.value!.id));

    final index = state.valueOrNull!.indexWhere((e) => e.id == todoId);
    final tmp = [...state.value!];
    final todo = (state.value![index]).copyWith(isDone: isDone);
    tmp[index] = todo;
    state = AsyncData(tmp);
    try {
      await repository.update(
        id: todo.id,
        isDone: isDone,
      );
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    _filterDoneIsTrueWithDebounce(
      milliseconds: milliseconds,
      onDeleted: onUpdated,
    );
  }

  /// [oldIndex]の[TodoItem]を[newIndex]に移動する
  Future<void> reorder(int oldIndex, int newIndex) async {
    final tmp = [...state.value!];
    final item = tmp.removeAt(oldIndex);
    tmp.insert(newIndex, item);
    state = AsyncData(tmp);

    // indexを更新する
    await updateCurrentOrder();
  }

  /// 現在のListの順番をindexとして更新する。
  ///
  /// 新規作成後や削除後に並び替えをリセットするために使用する。
  /// ショートカットでの移動時に連続で呼ばれる可能性があるため、APIの呼び出しはデバウンスしている。
  Future<void> updateCurrentOrder() async {
    final user = ref.read(userControllerProvider);
    if (user.valueOrNull == null) {
      assert(false, 'user is null');
      return;
    }
    final repository = ref.read(appItemRepositoryProvider(user.value!.id));

    final tmp = state.value!;
    for (var i = 0; i < tmp.length; i++) {
      tmp[i] = tmp[i].copyWith(index: i);
    }
    state = AsyncData(tmp);

    // 既存のデバウンスタイマーをキャンセル
    _updateOrderDebounce?.cancel();

    _updateOrderDebounce = Timer(const Duration(milliseconds: 500), () async {
      await repository.updateTodoOrder(todos: tmp);
    });
  }

  /// [Todo.isDone]がtrueのものをリストから削除する。
  ///
  /// このメソッドが[milliseconds]以内に複数回呼ばれた場合、最後の呼び出しのみが実行される。
  Future<void> _filterDoneIsTrueWithDebounce({
    int milliseconds = 1200,
    VoidCallback? onDeleted,
  }) async {
    // 既存のデバウンスタイマーをキャンセル
    _deleteDonesDebounce?.cancel();

    _deleteDonesDebounce =
        Timer(Duration(milliseconds: milliseconds), () async {
      final tmp = [
        ...state.value!.whereType<AppTodoItem>().where((e) => !e.isDone),
      ];
      state = AsyncData(tmp);
      onDeleted?.call();
    });
  }
}
