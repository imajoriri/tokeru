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
              child: const Text('start adding todos!'),
              onPressed: () async {
                ref.read(windowSizeModeControllerProvider.notifier).toLarge();
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
            ref
                .read(todoControllerProvider.notifier)
                .reorder(oldIndex, newIndex);
          },
          itemBuilder: (context, index) {
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
    final windowSizeMode = ref.watch(windowSizeModeControllerProvider);
    final offstate =
        index == 0 ? false : windowSizeMode == WindowSizeMode.small;
    final onHover = useState(false);
    return Offstage(
      offstage: offstate,
      child: MouseRegion(
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
                focusNode: ref.watch(todoFocusControllerProvider)[index],
                contentPadding: windowSizeMode == WindowSizeMode.large
                    ? null
                    : const EdgeInsets.symmetric(vertical: 8),
                onTapTextField: () {
                  ref.read(windowSizeModeControllerProvider.notifier).toLarge();
                },
                onChanged: (value) {
                  ref
                      .read(todoControllerProvider.notifier)
                      .updateTodoTitle(cartId: todo.id, title: value);
                },
                onChecked: (value) async {
                  await ref
                      .read(todoControllerProvider.notifier)
                      .updateIsDone(cartId: todo.id, isDone: value!);
                  ref
                      .read(todoControllerProvider.notifier)
                      .deleteDoneWithDebounce();
                },
                onAdd: () async {
                  await ref
                      .read(todoControllerProvider.notifier)
                      .add(index + 1);
                  await ref
                      .read(todoControllerProvider.notifier)
                      .updateCurrentOrder();
                  // rebuild後にnextFocusする
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ref
                        .read(todoFocusControllerProvider)[index + 1]
                        .requestFocus();
                  });
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
                onNextTodo: () {
                  ref.read(todoFocusControllerProvider.notifier).focusNext();
                },
                onPreviousTodo: () {
                  ref
                      .read(todoFocusControllerProvider.notifier)
                      .fucusPrevious();
                },
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
            if (onHover.value && windowSizeMode == WindowSizeMode.large)
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
      ),
    );
  }
}

class TodoListItem extends HookConsumerWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.focusNode,
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
    // NOTE: チェック時に`todo_controller`のTodoのisDoneは更新しているが、
    // idをkeyで割り当てているためリビルドされない。
    // そのため、このクラスで`isDone`を管理する。
    final isDone = useState(todo.isDone);

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
            value: isDone.value,
            onChanged: (val) {
              isDone.value = val ?? true;
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
                if (event is RawKeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.arrowDown &&
                      onNextTodo != null) {
                    onNextTodo?.call();
                    return KeyEventResult.handled;
                  }
                  if (event.logicalKey == LogicalKeyboardKey.arrowUp &&
                      onPreviousTodo != null) {
                    onPreviousTodo?.call();
                    return KeyEventResult.handled;
                  }
                  if (event.logicalKey == LogicalKeyboardKey.tab &&
                      onAddIndent != null) {
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
                  readOnly: isDone.value ? true : false,
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: isDone.value ? Colors.grey : Colors.black,
                  ),
                  maxLines: null,
                  // maxLinesがnullでもEnterで `onSubmitted`を検知するために
                  // `TextInputAction.done`である必要がある。
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    onAdd?.call();
                  },
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
    );
  }
}
