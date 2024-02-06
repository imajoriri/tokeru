part of 'screen.dart';

@Riverpod(keepAlive: true)
class TodoController extends _$TodoController {
  TodoRepository get todoRepository => ref.read(todoRepositoryProvider);
  @override
  FutureOr<List<Todo>> build() async {
    return todoRepository.fetchTodos();
  }

  Future<void> add(int index) async {
    try {
      final todo = await todoRepository.add();
      final tmp = [...state.value!];
      tmp.insert(index, todo);
      state = AsyncData(tmp);
    } on Exception catch (e) {
      print(e);
    }
  }

  void addIndent(Todo todo) {
    try {
      todoRepository.update(
        id: todo.id,
        indentLevel: todo.indentLevel + 1,
      );
    } on Exception catch (e) {
      print(e);
    }
    final tmp = [...state.value!];
    final index = tmp.indexWhere((element) => element.id == todo.id);
    tmp[index] = tmp[index].copyWith(indentLevel: tmp[index].indentLevel + 1);
    state = AsyncData(tmp);
  }

  void minusIndent(Todo todo) {
    try {
      todoRepository.update(
        id: todo.id,
        indentLevel: todo.indentLevel - 1,
      );
    } on Exception catch (e) {
      print(e);
    }
    final tmp = [...state.value!];
    final index = tmp.indexWhere((element) => element.id == todo.id);
    tmp[index] = tmp[index].copyWith(indentLevel: tmp[index].indentLevel - 1);
    state = AsyncData(tmp);
  }

  void delete(Todo todo) {
    try {
      todoRepository.delete(todo.id);
    } on Exception catch (e) {
      print(e);
    }
    final tmp = [...state.value!];
    tmp.removeWhere((element) => element.id == todo.id);
    state = AsyncData(tmp);
  }

  void updateTodo(int index, Todo todo) {
    try {
      // TODO: debounce
      todoRepository.update(
        id: todo.id,
        title: todo.title,
        isDone: todo.isDone,
        indentLevel: todo.indentLevel,
      );
    } on Exception catch (e) {
      print(e);
    }
    final tmp = [...state.value!];
    tmp[index] = todo;
    state = AsyncData(tmp);
  }
}

class TodoList extends HookConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoControllerProvider).valueOrNull ?? [];
    if (todos.isEmpty) {
      return ElevatedButton(
        onPressed: () {
          ref.read(todoControllerProvider.notifier).add(0);
        },
        child: const Text("追加"),
      );
    }
    return Column(
      children: [
        ...List.generate(todos.length, (index) {
          return TodoListItem(
            key: ValueKey(todos[index].id),
            todo: todos[index],
            onChanged: (value) {
              ref.read(todoControllerProvider.notifier).updateTodo(
                    index,
                    todos[index].copyWith(title: value),
                  );
            },
            onChecked: (value) {
              ref.read(todoControllerProvider.notifier).updateTodo(
                    index,
                    todos[index].copyWith(isDone: value ?? false),
                  );
            },
            onAdd: () async {
              await ref.read(todoControllerProvider.notifier).add(index + 1);
              // rebuild後にnextFocusする
              WidgetsBinding.instance.addPostFrameCallback((_) {
                FocusScope.of(context).nextFocus();
              });
            },
            onAddIndent: () {
              ref.read(todoControllerProvider.notifier).addIndent(todos[index]);
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
              ref.read(todoControllerProvider.notifier).delete(todos[index]);
            },
          );
        }),
      ],
    );
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
