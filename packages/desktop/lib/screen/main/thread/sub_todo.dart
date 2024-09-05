part of 'thread_view.dart';

/// サブタスクのリスト。
class _SubTodoList extends HookConsumerWidget {
  const _SubTodoList({
    required this.currentFocusIndex,
  });

  final ValueNotifier<int?> currentFocusIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parent = ref.watch(selectedThreadProvider)!;
    final provider = subTodosProvider(parent.id);
    final subTodos = ref.watch(provider);
    return subTodos.when(
      data: (todos) {
        return ReorderableListView.builder(
          buildDefaultDragHandles: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: todos.length,
          padding: EdgeInsets.symmetric(horizontal: context.appSpacing.small),
          onReorder: (oldIndex, newIndex) {
            // NOTE: なぜか上から下に移動するときはnewIndexが1つずれるので
            // その分を補正する
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            ref.read(provider.notifier).reorder(oldIndex, newIndex);
          },
          itemBuilder: (context, index) {
            final key = ValueKey(todos[index].id);
            final todo = todos[index];
            return HookBuilder(
              key: key,
              builder: (context) {
                final focusNode = useFocusNode();
                if (currentFocusIndex.value == index) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    focusNode.requestFocus();
                    currentFocusIndex.value = null;
                  });
                }
                final textEditingController = useTextEditingController(
                  text: todo.title,
                );
                return TodoListItem(
                  isDone: todo.isDone,
                  index: index,
                  textEditingController: textEditingController,
                  focusNode: focusNode,
                  onDeleted: () async {
                    ref.read(provider.notifier).delete(todoId: todo.id);
                  },
                  onUpdatedTitle: (value) {
                    ref
                        .read(provider.notifier)
                        .updateTitle(todoId: todo.id, title: value);
                  },
                  onToggleDone: (value) {
                    ref.read(provider.notifier).toggleDone(todoId: todo.id);
                  },
                  focusDown: FocusScope.of(context).nextFocus,
                  focusUp: FocusScope.of(context).previousFocus,
                  onNewTodoBelow: () async {
                    await ref.read(provider.notifier).addWithIndex(index + 1);
                    currentFocusIndex.value = index + 1;
                  },
                  // 一番上のTodoは上に移動できない
                  onSortUp: index != 0
                      ? () {
                          ref.read(provider.notifier).reorder(index, index - 1);
                        }
                      : null,
                  // 一番下のTodoは下に移動できない
                  onSortDown: index != todos.length - 1
                      ? () {
                          ref.read(provider.notifier).reorder(index, index + 1);
                        }
                      : null,
                );
              },
            );
          },
        );
      },
      loading: () {
        return const SizedBox();
      },
      error: (error, _) {
        return const SizedBox();
      },
    );
  }
}
