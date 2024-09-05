import 'dart:async';

import 'package:collection/collection.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_model/repository/app_item/app_item_repository.dart';
import 'package:uuid/uuid.dart';

part 'sub_todos.g.dart';

/// サブTodoのリストを扱うコントローラー。
@riverpod
class SubTodos extends _$SubTodos {
  StreamSubscription? _streamSub;
  Timer? _updateOrderDebounce;

  /// サブTodoの最後のindexを取得する。
  ///
  /// 空やnullの場合は0を返す。
  int get lastIndex =>
      state.valueOrNull?.isNotEmpty == true ? state.valueOrNull!.last.index : 0;

  @override
  Stream<List<AppSubTodoItem>> build({
    required String parentId,
    required bool isDone,
  }) {
    _listen();

    ref.onDispose(() {
      _streamSub?.cancel();
    });
    return const Stream.empty();
  }

  _listen() {
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return const Stream.empty();
    }

    final repository = ref.read(appItemRepositoryProvider(user.value!.id));
    final todoQuery = repository.query(
      userId: user.requireValue.id,
      type: const ['sub_todo'],
      parentId: parentId,
      isDone: isDone,
    );
    _streamSub = todoQuery.snapshots().listen((event) async {
      state = AsyncData(
        event.docs
            .map((doc) => AppSubTodoItem.fromJson(doc.data()..['id'] = doc.id))
            .toList()
            .sorted((a, b) => a.index.compareTo(b.index)),
      );
    });
  }

  /// サブTodoを追加する。
  Future<void> addWithIndex(int index) async {
    final todo = AppSubTodoItem(
      id: const Uuid().v4(),
      title: '',
      isDone: false,
      index: index,
      parentId: parentId,
      createdAt: DateTime.now(),
    );
    final todos = [...state.valueOrNull!];
    todos.insert(index, todo);

    // indexを更新。
    for (var i = 0; i < todos.length; i++) {
      todos[i] = todos[i].copyWith(index: i);
    }

    final user = ref.read(userControllerProvider).requireValue;
    final repository = ref.read(appItemRepositoryProvider(user.id));
    try {
      await repository.addSubTodoAndUpdateOrder(
        userId: user.id,
        addedTodo: todo,
        todos: todos,
      );
      await repository.incrementSubTodoCount(id: parentId);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    return;
  }

  /// isDoneを更新する。
  void toggleDone({
    required String todoId,
  }) async {
    final subTodo = state.valueOrNull!.firstWhere((e) => e.id == todoId);
    final updatedSubTodo = subTodo.copyWith(isDone: !subTodo.isDone);

    final user = ref.read(userControllerProvider).requireValue;
    final repository = ref.read(appItemRepositoryProvider(user.id));
    try {
      await repository.update(item: updatedSubTodo);
      if (updatedSubTodo.isDone) {
        await repository.decrementSubTodoCount(id: parentId);
      } else {
        await repository.incrementSubTodoCount(id: parentId);
      }
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  /// タイトルを更新する。
  Future<void> updateTitle({
    required String todoId,
    required String title,
  }) async {
    // titleだけ更新。
    final todo = state.valueOrNull
        ?.firstWhereOrNull((e) => e.id == todoId)!
        .copyWith(title: title) as AppSubTodoItem;

    final user = ref.read(userControllerProvider).requireValue;
    final repository = ref.read(appItemRepositoryProvider(user.id));
    try {
      await repository.update(item: todo);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  /// 削除する。
  Future<void> delete({
    required String todoId,
  }) async {
    final user = ref.read(userControllerProvider).requireValue;
    final repository = ref.read(appItemRepositoryProvider(user.id));
    try {
      await repository.delete(id: todoId);
      await repository.decrementSubTodoCount(id: parentId);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  /// indexを並び替える。
  Future<void> reorder(int oldIndex, int newIndex) async {
    final tmp = [...state.value!];
    final item = tmp.removeAt(oldIndex);
    tmp.insert(newIndex, item);
    state = AsyncData(tmp);

    // indexを更新する
    await _updateCurrentOrder();
  }

  /// 現在のListの順番をindexとしてデータを更新する。
  ///
  /// 新規作成後や削除後に並び替えをリセットするために使用する。
  /// ショートカットでの移動時に連続で呼ばれる可能性があるため、APIの呼び出しはデバウンスしている。
  Future<void> _updateCurrentOrder({bool delay = true}) async {
    final user = ref.read(userControllerProvider).requireValue;

    final tmp = state.value!;
    for (var i = 0; i < tmp.length; i++) {
      tmp[i] = tmp[i].copyWith(index: i);
    }

    // 既存のデバウンスタイマーをキャンセル
    _updateOrderDebounce?.cancel();

    _updateOrderDebounce =
        Timer(Duration(milliseconds: delay ? 500 : 0), () async {
      final repository = ref.read(appItemRepositoryProvider(user.id));
      await repository.updateSubTodoOrder(
        userId: user.id,
        todos: tmp,
      );
    });
  }
}
