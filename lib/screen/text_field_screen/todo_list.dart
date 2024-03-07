part of 'screen.dart';

class TodoList extends HookConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoControllerProvider);
    final windowSizeMode = ref.watch(windowSizeModeControllerProvider);

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
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: todos.length,
          onReorder: (oldIndex, newIndex) {
            ref
                .read(todoControllerProvider.notifier)
                .reorder(oldIndex, newIndex);
          },
          itemBuilder: (context, index) {
            final offstate =
                index == 0 ? false : windowSizeMode == WindowSizeMode.small;
            return Offstage(
              key: ValueKey(todos[index].id),
              offstage: offstate,
              child: TodoListItem(
                todo: todos[index],
                contentPadding: windowSizeMode == WindowSizeMode.large
                    ? null
                    : const EdgeInsets.symmetric(vertical: 20),
                onTapTextField: () {
                  ref.read(windowSizeModeControllerProvider.notifier).toLarge();
                },
                onChanged: (value) {
                  ref
                      .read(todoControllerProvider.notifier)
                      .updateTodoTitle(cartId: todos[index].id, title: value);
                },
                onChecked: (value) async {
                  await ref
                      .read(todoControllerProvider.notifier)
                      .updateIsDone(index);
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
                onNextTodo: () {
                  if (index + 1 < todos.length) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                onPreviousTodo: () {
                  if (index != 0) {
                    FocusScope.of(context).previousFocus();
                  }
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
              ),
            );
          },
        );
      },
      error: (e, s) => const Text('happen somethings'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class TodoListItem extends HookConsumerWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    this.onTapTextField,
    this.onChecked,
    this.onChanged,
    this.onAdd,
    this.onAddIndent,
    this.onMinusIndent,
    this.onNextTodo,
    this.onPreviousTodo,
    this.onDelete,
    this.contentPadding,
  });

  final Todo todo;

  /// チェックされた時
  final void Function(bool?)? onChecked;

  /// TextFieldがtapされた時
  final void Function()? onTapTextField;

  /// TextFieldのcontentPadding
  final EdgeInsets? contentPadding;

  /// checkboxの状態が変更されたときに呼ばれる
  ///
  /// [debounceDuration]の時間が経過するまで呼ばれない
  final void Function(String)? onChanged;

  /// 追加ボタンが押されたときに呼ばれる
  final void Function()? onAdd;

  /// インデント追加
  final void Function()? onAddIndent;

  /// インデント削除
  final void Function()? onMinusIndent;

  /// Todo削除
  final void Function()? onDelete;

  /// 次のTodoへ移動する
  ///
  /// [LogicalKeyboardKey.arrowDown]が押されたときに呼ばれる
  final void Function()? onNextTodo;

  /// 前のTodoへ移動する
  ///
  /// [LogicalKeyboardKey.arrowUp]が押されたときに呼ばれる
  final void Function()? onPreviousTodo;

  /// debouce用のDuration
  static const debounceDuration = Duration(milliseconds: 400);

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
            onChanged?.call(controller.text);
          });
        });

        return () {
          debounce?.cancel();
        };
      },
      [controller],
    );
    return Padding(
      padding: EdgeInsets.only(
        bottom: 4,
        top: 4,
        // indexに応じて左にpaddingを追加する
        left: 20 * todo.indentLevel.toDouble(),
      ),
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
                    onNextTodo?.call();
                    return KeyEventResult.handled;
                  }
                  if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                    onPreviousTodo?.call();
                    return KeyEventResult.handled;
                  }
                  if (event.logicalKey == LogicalKeyboardKey.tab) {
                    onAddIndent?.call();
                    return KeyEventResult.handled;
                  }
                  // バックスペースキー & カーソルが先頭の場合
                  if (event.logicalKey == LogicalKeyboardKey.backspace &&
                      controller.selection.baseOffset == 0 &&
                      controller.selection.extentOffset == 0) {
                    // indentが0の場合は削除する
                    if (todo.indentLevel == 0) {
                      onDelete?.call();
                      return KeyEventResult.handled;
                    }
                    // indentが1以上の場合はインデントをマイナスする
                    onMinusIndent?.call();
                    return KeyEventResult.handled;
                  }
                }
                return KeyEventResult.ignored;
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  onSubmitted: (value) {
                    // フォーカスが外れてしまうため、意図的にフォーカスを戻す
                    focusNode.requestFocus();
                    onAdd?.call();
                  },
                  onTap: () {
                    onTapTextField?.call();
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // チェックボックスとの高さを調整するためのpadding
                    contentPadding: contentPadding,
                    hintText: 'write a todo...',
                    isCollapsed: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
