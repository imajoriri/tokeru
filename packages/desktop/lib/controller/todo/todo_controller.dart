import 'dart:async';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:tokeru_desktop/controller/refresh/refresh_controller.dart';
import 'package:tokeru_desktop/controller/user/user_controller.dart';
import 'package:tokeru_model/model.dart';
import 'package:tokeru_desktop/repository/app_item/app_item_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo_controller.g.dart';

/// 未完了の[AppTodoItem]を返すController。
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
    final todos = await repository.fetchTodos(
      isDone: false,
    );
    // sort
    todos.sort((a, b) {
      return a.index.compareTo(b.index);
    });
    return todos;
  }

  /// 現在のListの順番をindexとしてデータを更新する。
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

    // 既存のデバウンスタイマーをキャンセル
    _updateOrderDebounce?.cancel();

    _updateOrderDebounce = Timer(const Duration(milliseconds: 500), () async {
      final repository = ref.read(appItemRepositoryProvider(user.value!.id));
      await repository.updateTodoOrder(todos: tmp);
    });
  }

  /// [AppTodoItem]の更新。
  // NOTE: AppTodoItem自体を受け取ってしまうと、リビルド前の値を参照してしまう可能性があるため、
  // idを受け取って更新する。
  Future<void> updateTodoTitle({
    required String todoId,
    required String title,
  }) async {
    final user = ref.read(userControllerProvider);
    if (user.valueOrNull == null) {
      assert(false, 'user is null');
      return;
    }

    // titleだけ更新。
    final todo = state.valueOrNull
        ?.firstWhereOrNull((e) => e.id == todoId)!
        .copyWith(title: title) as AppTodoItem;

    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    try {
      await repository.update(item: todo);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  /// 特定のIndexに[AppTodoItem]を追加する。
  ///
  /// 特定のIndexにTodoを追加した後に、全てのTodoのindexを更新する。
  /// [index]が配列の長さを超えている場合は、最後に追加される。
  Future<void> addTodoWithIndex({
    required int index,
  }) async {
    final user = ref.read(userControllerProvider);
    if (user.valueOrNull == null) {
      assert(false, 'user is null');
      return;
    }

    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    final todo = AppTodoItem(
      id: const Uuid().v4(),
      title: '',
      isDone: false,
      index: index,
      createdAt: DateTime.now(),
    );
    final todos = [...state.valueOrNull!];
    todos.insert(index, todo);
    state = AsyncData(todos);

    await repository.add(todo);

    updateCurrentOrder();
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

    final user = ref.read(userControllerProvider);
    if (user.valueOrNull == null) {
      assert(false, 'user is null');
      return;
    }

    // stateから削除
    state = AsyncData(
      state.valueOrNull!.where((e) => e.id != todoId).toList(),
    );

    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    try {
      await repository.delete(id: todoId);
      updateCurrentOrder();
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  /// [AppTodoItem]を更新する。
  ///
  /// 存在しない場合は、何もしない。
  /// - [milliseconds]: デバウンスする時間。この時間内に複数回呼ばれた場合、最後の呼び出しのみが実行される。
  /// - [onUpdated]: 更新後に実行するコールバック。
  void toggleTodoDone({
    required String todoId,
    int milliseconds = 200,
    VoidCallback? onUpdated,
  }) async {
    late final AppTodoItem todo;
    state = AsyncData(
      state.valueOrNull!.map((e) {
        if (e.id == todoId) {
          todo = e.copyWith(isDone: !e.isDone);
          return todo;
        }
        return e;
      }).toList(),
    );
    _filterDoneIsTrueWithDebounce(
      todo: todo,
      milliseconds: milliseconds,
      onDeleted: onUpdated,
    );
  }

  /// 現在のListの順番をindexとして更新する。
  ///
  /// 新規作成後や削除後に並び替えをリセットするために使用する。
  /// ショートカットでの移動時に連続で呼ばれる可能性があるため、APIの呼び出しはデバウンスしている。
  Future<void> _filterDoneIsTrueWithDebounce({
    required AppTodoItem todo,
    int milliseconds = 200,
    VoidCallback? onDeleted,
  }) async {
    _deleteDonesDebounce?.cancel();

    _deleteDonesDebounce =
        Timer(Duration(milliseconds: milliseconds), () async {
      final user = ref.read(userControllerProvider);
      final repository = ref.read(appItemRepositoryProvider(user.value!.id));
      await repository.update(item: todo);
      updateCurrentOrder();
      state = AsyncData(
        state.valueOrNull!.where((e) => e.isDone == false).toList(),
      );
      onDeleted?.call();
    });
  }
}
