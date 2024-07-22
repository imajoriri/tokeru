import 'dart:async';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// [AppTodoItem]の更新、削除、並び替えを行うMixin。
mixin AppTodoItemsNotifierMixin<T> on StreamNotifier<List<AppTodoItem>> {
  Timer? _deleteDonesDebounce;
  Timer? _updateOrderDebounce;

  /// [AppTodoItem]を追加する。
  void addTodo({
    required AppTodoItem todo,
  }) {
    final index = todo.index;
    // todoのindexから、実際の配列のindexを計算する
    final indexInList =
        index > state.valueOrNull!.length ? state.valueOrNull!.length : index;
    final tmp = [...state.valueOrNull!];
    tmp.insert(indexInList, todo);
    state = AsyncData(tmp);
  }

  /// [oldIndex]の[AppTodoItem]を[newIndex]に移動する
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

    final tmp = state.value!;
    for (var i = 0; i < tmp.length; i++) {
      tmp[i] = tmp[i].copyWith(index: i);
    }
    state = AsyncData(tmp);

    // 既存のデバウンスタイマーをキャンセル
    _updateOrderDebounce?.cancel();

    _updateOrderDebounce = Timer(const Duration(milliseconds: 500), () async {
      final repository = ref.read(appItemRepositoryProvider(user.value!.id));
      await repository.updateTodoOrder(todos: tmp);
    });
  }

  /// [AppTodoItem]を削除する
  ///
  /// [AppTodoItem]が存在しない場合は何もしない。
  void deleteTodo({
    required String todoId,
  }) async {
    final oldTodo = state.valueOrNull?.firstWhereOrNull((e) => e.id == todoId);
    if (oldTodo == null) {
      return;
    }

    state = AsyncData(
      state.valueOrNull!.where((e) => e.id != todoId).toList(),
    );
  }

  /// [AppTodoItem]を更新する。
  ///
  /// 存在しない場合は、何もしない。
  /// - [milliseconds]: デバウンスする時間。この時間内に複数回呼ばれた場合、最後の呼び出しのみが実行される。
  /// - [onUpdated]: 更新後に実行するコールバック。
  void updateTodo({
    required AppTodoItem todo,
    int milliseconds = 1200,
    VoidCallback? onUpdated,
  }) async {
    final oldTodo = state.valueOrNull?.firstWhereOrNull((e) => e.id == todo.id);
    if (oldTodo == null) {
      return;
    }

    state = AsyncData(
      state.valueOrNull!.map((e) {
        if (e.id == todo.id) {
          return todo;
        }
        return e;
      }).toList(),
    );
    _filterDoneIsTrueWithDebounce(
      milliseconds: milliseconds,
      onDeleted: onUpdated,
    );
  }

  /// 現在のListの順番をindexとして更新する。
  ///
  /// 新規作成後や削除後に並び替えをリセットするために使用する。
  /// ショートカットでの移動時に連続で呼ばれる可能性があるため、APIの呼び出しはデバウンスしている。
  Future<void> _filterDoneIsTrueWithDebounce({
    int milliseconds = 1200,
    VoidCallback? onDeleted,
  }) async {
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
