import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:quick_flutter/repository/todo/todo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_controller.g.dart';

@Riverpod(keepAlive: true)
class TodoController extends _$TodoController {
  TodoRepository get todoRepository => ref.read(todoRepositoryProvider);
  @override
  FutureOr<List<Todo>> build() async {
    final user = ref.watch(userControllerProvider);
    if (user.valueOrNull == null) {
      return [];
    }

    final todos = await todoRepository.fetchTodos(userId: user.value!.id);
    // index順に並び替える
    todos.sort((a, b) => a.index.compareTo(b.index));
    return todos;
  }

  /// Todoを追加する
  Future<void> add(int index) async {
    final user = ref.watch(userControllerProvider);
    if (user.valueOrNull == null) {
      return;
    }
    try {
      final todo =
          await todoRepository.add(userId: user.valueOrNull!.id, index: index);
      final tmp = [...state.value!];
      tmp.insert(index, todo);
      state = AsyncData(tmp);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  /// インデントを追加する
  Future<void> addIndent(Todo todo) async {
    final user = ref.watch(userControllerProvider);
    if (user.valueOrNull == null) {
      return;
    }
    try {
      todoRepository.update(
        userId: user.valueOrNull!.id,
        id: todo.id,
        indentLevel: todo.indentLevel + 1,
      );
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    final tmp = [...state.value!];
    final index = tmp.indexWhere((element) => element.id == todo.id);
    tmp[index] = tmp[index].copyWith(indentLevel: tmp[index].indentLevel + 1);
    state = AsyncData(tmp);
  }

  /// インデントを削除する
  Future<void> minusIndent(Todo todo) async {
    final user = ref.watch(userControllerProvider);
    if (user.valueOrNull == null) {
      return;
    }
    try {
      todoRepository.update(
        userId: user.valueOrNull!.id,
        id: todo.id,
        indentLevel: todo.indentLevel - 1,
      );
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    final tmp = [...state.value!];
    final index = tmp.indexWhere((element) => element.id == todo.id);
    tmp[index] = tmp[index].copyWith(indentLevel: tmp[index].indentLevel - 1);
    state = AsyncData(tmp);
  }

  /// Todoを削除する
  Future<void> delete(Todo todo) async {
    final user = ref.watch(userControllerProvider);
    if (user.valueOrNull == null) {
      return;
    }
    try {
      todoRepository.delete(userId: user.valueOrNull!.id, id: todo.id);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    final tmp = [...state.value!];
    tmp.removeWhere((element) => element.id == todo.id);
    state = AsyncData(tmp);
  }

  /// Todoを更新する
  Future<void> updateTodo(int index, Todo todo) async {
    final user = ref.watch(userControllerProvider);
    if (user.valueOrNull == null) {
      return;
    }
    try {
      todoRepository.update(
        userId: user.valueOrNull!.id,
        id: todo.id,
        title: todo.title,
        isDone: todo.isDone,
        indentLevel: todo.indentLevel,
      );
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    final tmp = [...state.value!];
    tmp[index] = todo;
    state = AsyncData(tmp);
  }

  /// [oldIndex]の[Todo]を[newIndex]に移動する
  Future<void> reorder(int oldIndex, int newIndex) async {
    final tmp = [...state.value!];
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = tmp.removeAt(oldIndex);
    tmp.insert(newIndex, item);
    state = AsyncData(tmp);

    final user = ref.watch(userControllerProvider);
    if (user.valueOrNull == null) {
      return;
    }

    // indexを更新する
    await ref
        .read(todoRepositoryProvider)
        .updateOrder(userId: user.value!.id, todos: tmp);
  }

  /// 現在のListの順番をindexとして更新する。
  /// 新規作成後や削除後に並び替えをリセットするために使用する
  Future<void> updateCurrentOrder() async {
    final tmp = state.value!;
    for (var i = 0; i < tmp.length; i++) {
      tmp[i] = tmp[i].copyWith(index: i);
    }
    state = AsyncData(tmp);

    final user = ref.watch(userControllerProvider);
    if (user.valueOrNull == null) {
      return;
    }
    await ref
        .read(todoRepositoryProvider)
        .updateOrder(userId: user.value!.id, todos: tmp);
  }
}
