part of 'screen.dart';

class TodoList extends HookConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoControllerProvider);
    return todos.when(
      data: (todos) {
        if (todos.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: const Text('start todos!'),
              onPressed: () async {
                await ref.read(todoControllerProvider.notifier).add(0);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref
                      .read(todoFocusControllerProvider.notifier)
                      .requestFocus(0);
                });

                await FirebaseAnalytics.instance.logEvent(
                  name: AnalyticsEventName.addTodo.name,
                );
              },
            ),
          );
        }
        return ReorderableListView.builder(
          buildDefaultDragHandles: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: todos.length,
          onReorder: (oldIndex, newIndex) {
            // NOTE: なぜか上から下に移動するときはnewIndexが1つずれるので
            // その分を補正する
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            ref
                .read(todoControllerProvider.notifier)
                .reorder(oldIndex, newIndex);
          },
          itemBuilder: (context, index) {
            // isDoneが更新されてもWidgetが更新されて欲しいので、idとisDoneをkeyにする
            final key = ValueKey(todos[index].id);
            return _ReorderableTodoListItem(
              key: key,
              todo: todos[index],
              index: index,
              todoLength: todos.length,
            );
          },
        );
      },
      error: (e, s) => const Text('happen somethings'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

/// [ReorderableListView]の中で使う[Todo]のリスト
class _ReorderableTodoListItem extends HookConsumerWidget {
  const _ReorderableTodoListItem({
    super.key,
    required this.todo,
    required this.index,
    required this.todoLength,
  });

  /// リストのindex
  final int index;

  /// Todo
  final Todo todo;

  /// [Todo]の個数
  final int todoLength;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onHover = useState(false);
    return MouseRegion(
      onEnter: (_) => onHover.value = true,
      onExit: (_) => onHover.value = false,
      child: Stack(
        children: [
          Padding(
            padding: index == todoLength - 1
                ? const EdgeInsets.only(bottom: 4)
                : EdgeInsets.zero,
            child: TodoListItem(
              todo: todo,
              isFirst: index == 0,
              isLast: index == todoLength - 1,
              focusNode: ref.watch(todoFocusControllerProvider)[index],
              onChanged: (value) {
                ref
                    .read(todoControllerProvider.notifier)
                    .updateTodoTitle(cartId: todo.id, title: value);
              },
              onChecked: (value) async {
                await ref
                    .read(todoControllerProvider.notifier)
                    .updateIsDone(todoId: todo.id, isDone: value!);
                ref
                    .read(todoControllerProvider.notifier)
                    .deleteDoneWithDebounce();
              },
              onAdd: () async {
                // 現在のfocusを外さないと、新しいTodoが追加されたときに
                // focusが2重になってしまうため、一旦外す
                ref.read(todoFocusControllerProvider.notifier).removeFocus();

                await ref.read(todoControllerProvider.notifier).add(index + 1);
                await ref
                    .read(todoControllerProvider.notifier)
                    .updateCurrentOrder();
                ref
                    .read(todoFocusControllerProvider.notifier)
                    .requestFocus(index + 1);
              },
              // インデント機能は一旦オミット
              // onAddIndent: () {
              // ref
              //     .read(todoControllerProvider.notifier)
              //     .addIndent(todos[index]);
              // },
              // onMinusIndent: () {
              //   ref
              //       .read(todoControllerProvider.notifier)
              //       .minusIndent(todos[index]);
              // },
              focusNext:
                  ref.read(todoFocusControllerProvider.notifier).focusNext,
              focusPrevious:
                  ref.read(todoFocusControllerProvider.notifier).focusPrevious,
              onDelete: () async {
                await ref.read(todoControllerProvider.notifier).delete(todo);
                // 最後の１つの場合、previousFoucsすると他のFocusに移動しちゃうため
                if (todoLength != 1) {
                  ref
                      .read(todoFocusControllerProvider.notifier)
                      .requestFocus(index - 1);
                }
              },
            ),
          ),
          // ドラッグ&ドロップのアイコン
          if (onHover.value)
            Positioned.directional(
              textDirection: Directionality.of(context),
              top: 0,
              bottom: 0,
              end: 8,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: ReorderableDragStartListener(
                  index: index,
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.grab,
                    child: Icon(
                      Icons.drag_indicator_outlined,
                      color: Colors.grey,
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

class TodoListItem extends HookWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.isFirst,
    required this.isLast,
    required this.focusNode,
    this.onTapTextField,
    this.onChecked,
    this.onChanged,
    this.onAdd,
    this.onAddIndent,
    this.onMinusIndent,
    this.focusNext,
    this.focusPrevious,
    this.onDelete,
    this.contentPadding,
  });

  final Todo todo;

  /// リストの最後の[Todo]かどうか
  final bool isLast;

  /// リストの最初の[Todo]かどうか
  final bool isFirst;

  final FocusNode focusNode;

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

  /// 次のTodoにフォーカスを移動する
  ///
  /// [isFirst]がtrueの場合は何もしない
  final void Function()? focusNext;

  /// 前のTodoにフォーカスを移動する
  ///
  /// [isLast]がtrueの場合は何もしない
  final void Function()? focusPrevious;

  /// Todo削除
  final void Function()? onDelete;

  /// debouce用のDuration
  static const debounceDuration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: todo.title);
    final hasFocus = useState(focusNode.hasFocus);
    final isPressedShift = useState(false);

    useEffect(
      () {
        listener() {
          hasFocus.value = focusNode.hasFocus;
        }

        focusNode.addListener(listener);
        return () {
          focusNode.removeListener(listener);
        };
      },
      [focusNode],
    );

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
    return Stack(
      fit: StackFit.passthrough,
      children: [
        // TextFieldを囲っているContainerに色を付けると
        // リビルド時にfocusが外れてしまうため、stackでContainerを分けている
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            color: hasFocus.value
                ? context.colorScheme.primary.withOpacity(0.1)
                : Colors.transparent,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 4,
            top: 4,
            // indexに応じて左にpaddingを追加する
            left: 20 * todo.indentLevel.toDouble(),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: todo.isDone,
                onChanged: (val) {
                  onChecked?.call(val);
                },
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

                    // キーが押された時のイベント群
                    if (event is RawKeyDownEvent) {
                      // Shiftキーが押されたかどうか
                      if (event.logicalKey == LogicalKeyboardKey.shiftLeft) {
                        isPressedShift.value = true;
                      }

                      // Enterが押されたとき、Shiftキーが押されていない場合は`onAdd`を呼ぶ
                      if (event.logicalKey == LogicalKeyboardKey.enter &&
                          !isPressedShift.value) {
                        onAdd?.call();
                        return KeyEventResult.handled;
                      }

                      // Tabが押されたとき、`onAddIndent`を呼ぶ
                      if (event.logicalKey == LogicalKeyboardKey.tab &&
                          onAddIndent != null) {
                        onAddIndent?.call();
                        return KeyEventResult.handled;
                      }

                      // 上矢印キーが押されたとき、複数行入力されていた場合は
                      // 行を1つ上に移動する
                      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                        // カーソルより前に改行があるかどうか
                        final hasNewLineBeforeCurrentCursor = controller.text
                            .substring(0, controller.selection.baseOffset)
                            .contains('\n');
                        if (hasNewLineBeforeCurrentCursor || isFirst) {
                          return KeyEventResult.ignored;
                        } else {
                          focusPrevious?.call();
                          return KeyEventResult.handled;
                        }
                      }

                      // 下矢印キーが押されたとき、複数行入力されていた場合は
                      // 行を1つ下に移動する
                      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                        // カーソルより後に改行があるかどうか
                        final hasNewLineAfterCurrentCursor = controller.text
                            .substring(controller.selection.baseOffset)
                            .contains('\n');
                        if (hasNewLineAfterCurrentCursor || isLast) {
                          return KeyEventResult.ignored;
                        } else {
                          focusNext?.call();
                          return KeyEventResult.handled;
                        }
                      }
                    }

                    // キーが離された時のイベント群
                    if (event is RawKeyUpEvent) {
                      if (event.logicalKey == LogicalKeyboardKey.shiftLeft) {
                        isPressedShift.value = false;
                      }

                      // バックスペースキー & カーソルが先頭のケース
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
                    padding: const EdgeInsets.only(
                      bottom: 4,
                      // チェックボックスとの高さを調整するためのpadding
                      top: 6,
                    ),
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: todo.isDone ? Colors.grey : Colors.black,
                      ),
                      maxLines: null,
                      onTap: () {
                        onTapTextField?.call();
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // チェックボックスとの高さを調整するためのpadding
                        contentPadding: contentPadding,
                        hintText: 'Write a todo...',
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
