part of 'todo_screen.dart';

class TodoList extends HookConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Today', style: context.appTextTheme.titleSmall),
        ),

        // TodoList
        todos.when(
          data: (todos) {
            if (todos.isEmpty) {
              return GestureDetector(
                onTap: Actions.handler<NewTodoIntent>(
                  context,
                  const NewTodoIntent(),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        'There are no To-Dos for today.\nPlease start by clicking here or pressing Command + N.',
                        style: context.appTextTheme.bodySmall.copyWith(
                          color: context.appColors.textSubtle,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: Actions.handler<NewTodoIntent>(
                          context,
                          const NewTodoIntent(),
                        ),
                        child: const Text('Add To-Do'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ReorderableListView.builder(
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
                  final key = Key(todos[index].id);
                  return _ReorderableTodoListItem(
                    key: key,
                    todo: todos[index],
                    index: index,
                    todoLength: todos.length,
                  );
                },
              ),
            );
          },
          error: (e, s) => const Text('happen somethings'),
          loading: () => const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Loading...'),
          ),
        ),
      ],
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
  final TodoItem todo;

  /// [Todo]の個数
  final int todoLength;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onHover = useState(false);
    // 日本語入力などでの変換中は無視するためのフラグ
    final isValid = useState(false);
    final focus = ref.watch(todoFocusControllerProvider)[index];
    final controller = ref.watch(todoTextEditingControllerProvider(todo.id));

    focus.onKey = ((node, event) {
      isValid.value = controller.value.composing.isValid;
      return KeyEventResult.ignored;
    });

    useEffect(
      () {
        listener() {
          if (focus.hasFocus) {
            ref
                .read(selectedTodoItemIdControllerProvider.notifier)
                .select(todo.id);
          }
        }

        focus.addListener(listener);
        return () {
          focus.removeListener(listener);
        };
      },
      [focus],
    );

    return MouseRegion(
      onEnter: (_) => onHover.value = true,
      onExit: (_) => onHover.value = false,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.zero,
            child: switch (todo) {
              Todo() => Actions(
                  actions: {
                    FocusUpIntent: ref.watch(todoFocusUpActionProvider),
                    FocusDownIntent: ref.watch(todoFocusDownActionProvider),
                    ToggleTodoDoneIntent:
                        ref.watch(toggleTodoDoneActionProvider),
                    MoveUpTodoIntent: ref.watch(moveUpTodoActionProvider),
                    MoveDownTodoIntent: ref.watch(moveDownTodoActionProvider),
                    DeleteTodoIntent: ref.watch(deleteTodoActionProvider),
                    if (!isValid.value)
                      NewTodoBelowIntent: ref.watch(newTodoBelowActionProvider),
                  },
                  child: TodoListItem(
                    todo: todo as Todo,
                    focusNode: ref.watch(todoFocusControllerProvider)[index],
                    controller:
                        ref.watch(todoTextEditingControllerProvider(todo.id)),
                    selected: ref.watch(selectedTodoItemIdControllerProvider) ==
                        todo.id,
                    onDeleted: () async {
                      final currentFocusIndex = ref
                          .read(todoFocusControllerProvider.notifier)
                          .getFocusIndex();
                      await ref
                          .read(todoControllerProvider.notifier)
                          .delete(todo);
                      ref
                          .read(todoFocusControllerProvider.notifier)
                          .requestFocus(currentFocusIndex - 1);
                    },
                    onUpdate: (value) => ref
                        .read(todoControllerProvider.notifier)
                        .updateTodoTitle(todoId: todo.id, title: value),
                    onToggleDone: (value) {
                      ref.read(todoControllerProvider.notifier).updateIsDone(
                            todoId: todo.id,
                            isDone: value ?? false,
                          );
                      FirebaseAnalytics.instance.logEvent(
                        name: AnalyticsEventName.toggleTodoDone.name,
                      );
                    },
                  ),
                ),
              TodoDivider() => const Text("divider"),
            },
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
