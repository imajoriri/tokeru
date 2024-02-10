part of 'screen.dart';

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
  ///
  /// [debounceDuration]の時間が経過するまで呼ばれない
  final void Function(String) onChanged;

  /// 追加ボタンが押されたときに呼ばれる
  final void Function() onAdd;

  /// インデント追加
  final void Function() onAddIndent;

  /// インデント削除
  final void Function() onMinusIndent;

  /// Todo削除
  final void Function() onDelete;

  /// debouce用のDuration
  static const debounceDuration = Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: todo.title);
    final focusNode = useFocusNode();

    Timer? debounce;
    useEffect(
      () {
        controller.addListener(() {
          if (debounce?.isActive ?? false) {
            debounce?.cancel();
          }

          debounce = Timer(debounceDuration, () {
            onChanged.call(controller.text);
          });
        });

        return () {
          debounce?.cancel();
        };
      },
      [controller],
    );
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
