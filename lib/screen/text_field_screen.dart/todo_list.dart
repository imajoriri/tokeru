part of 'screen.dart';

@Riverpod(keepAlive: true)
class TodoController extends _$TodoController {
  TodoRepository get todoRepository => ref.read(todoRepositoryProvider);
  @override
  FutureOr<List<Todo>> build() async {
    final todos = await todoRepository.fetchTodos();
    // index順に並び替える
    todos.sort((a, b) => a.index.compareTo(b.index));
    return todos;
  }

  /// Todoを追加する
  Future<void> add(int index) async {
    try {
      final todo = await todoRepository.add();
      final tmp = [...state.value!];
      tmp.insert(index, todo);
      state = AsyncData(tmp);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  /// インデントを追加する
  Future<void> addIndent(Todo todo) async {
    try {
      todoRepository.update(
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
    try {
      todoRepository.update(
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
    try {
      todoRepository.delete(todo.id);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
    final tmp = [...state.value!];
    tmp.removeWhere((element) => element.id == todo.id);
    state = AsyncData(tmp);
  }

  /// Todoを更新する
  Future<void> updateTodo(int index, Todo todo) async {
    try {
      todoRepository.update(
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

    // indexを更新する
    await ref.read(todoRepositoryProvider).updateOrder(tmp);
  }

  /// 現在のListの順番をindexとして更新する。
  /// 新規作成後や削除後に並び替えをリセットするために使用する
  Future<void> updateCurrentOrder() async {
    final tmp = state.value!;
    for (var i = 0; i < tmp.length; i++) {
      tmp[i] = tmp[i].copyWith(index: i);
    }
    state = AsyncData(tmp);
    await ref.read(todoRepositoryProvider).updateOrder(tmp);
  }
}

class TodoList extends HookConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoControllerProvider);
    return todos.when(
        data: (todos) {
          if (todos.isEmpty) {
            return ElevatedButton(
              onPressed: () {
                ref.read(todoControllerProvider.notifier).add(0);
              },
              child: const Text("追加"),
            );
          }
          return ReorderableListView.builder(
            shrinkWrap: true,
            itemCount: todos.length,
            onReorder: (oldIndex, newIndex) {
              ref
                  .read(todoControllerProvider.notifier)
                  .reorder(oldIndex, newIndex);
            },
            itemBuilder: (context, index) {
              return TodoListItem(
                key: ValueKey(todos[index].id),
                todo: todos[index],
                onChanged: (value) {
                  ref.read(todoControllerProvider.notifier).updateTodo(
                        index,
                        todos[index].copyWith(title: value),
                      );
                },
                onChecked: (value) async {
                  await ref.read(todoControllerProvider.notifier).updateTodo(
                        index,
                        todos[index].copyWith(isDone: value ?? false),
                      );
                  ref.invalidate(todoControllerProvider);
                },
                onAdd: () async {
                  await ref
                      .read(todoControllerProvider.notifier)
                      .add(index + 1);
                  ref
                      .read(todoControllerProvider.notifier)
                      .updateCurrentOrder();
                  // rebuild後にnextFocusする
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    FocusScope.of(context).nextFocus();
                  });
                },
                onAddIndent: () {
                  ref
                      .read(todoControllerProvider.notifier)
                      .addIndent(todos[index]);
                },
                onMinusIndent: () {
                  ref
                      .read(todoControllerProvider.notifier)
                      .minusIndent(todos[index]);
                },
                onDelete: () {
                  // 最後の１つの場合、previousFoucsすると他のFocusに移動しちゃうため
                  if (todos.length != 1) {
                    FocusScope.of(context).previousFocus();
                  }
                  ref
                      .read(todoControllerProvider.notifier)
                      .delete(todos[index]);
                },
              );
            },
          );
        },
        error: (e, s) => const Text('happen somethings'),
        loading: () => const CircularProgressIndicator());
  }
}

class TodoListItem extends HookConsumerWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.onChecked,
    required this.onChanged,
    required this.onAdd,
    required this.onAddIndent,
    required this.onMinusIndent,
    required this.onDelete,
  });

  final Todo todo;

  /// チェックされた時
  final void Function(bool?) onChecked;

  /// checkboxの状態が変更されたときに呼ばれる
  final void Function(String) onChanged;

  /// 追加ボタンが押されたときに呼ばれる
  final void Function() onAdd;

  /// インデント追加
  final void Function() onAddIndent;

  /// インデント削除
  final void Function() onMinusIndent;

  /// Todo削除
  final void Function() onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: todo.title);
    final focusNode = useFocusNode();
    return Padding(
      padding: EdgeInsets.only(left: 20 * todo.indentLevel.toDouble()),
      child: Row(
        children: [
          Checkbox(
            value: todo.isDone,
            onChanged: onChecked,
            focusNode: useFocusNode(
              skipTraversal: true,
            ),
          ),
          Expanded(
            child: Focus(
              skipTraversal: true,
              onKey: (node, event) {
                // 日本語入力などでの変換中は無視する
                if (controller.value.composing.isValid) {
                  return KeyEventResult.ignored;
                }
                if (event is RawKeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                    FocusScope.of(context).nextFocus();
                    return KeyEventResult.handled;
                  }
                  if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                    FocusScope.of(context).previousFocus();
                    return KeyEventResult.handled;
                  }
                  if (event.logicalKey == LogicalKeyboardKey.tab) {
                    onAddIndent();
                    return KeyEventResult.handled;
                  }
                  // バックスペースキー & カーソルが先頭の場合
                  if (event.logicalKey == LogicalKeyboardKey.backspace &&
                      controller.selection.baseOffset == 0 &&
                      controller.selection.extentOffset == 0) {
                    // indentが0の場合は削除する
                    if (todo.indentLevel == 0) {
                      onDelete();
                      return KeyEventResult.handled;
                    }
                    // indentが1以上の場合はインデントをマイナスする
                    onMinusIndent();
                    return KeyEventResult.handled;
                  }
                }
                return KeyEventResult.ignored;
              },
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                focusNode: focusNode,
                onSubmitted: (value) {
                  // フォーカスが外れてしまうため、意図的にフォーカスを戻す
                  focusNode.requestFocus();
                  onAdd();
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(4),
                  hintText: 'メッセージを入力',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
