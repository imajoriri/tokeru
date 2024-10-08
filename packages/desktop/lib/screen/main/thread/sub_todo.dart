part of 'thread_view.dart';

/// サブタスクのリスト。
class _SubTodoList extends HookConsumerWidget {
  const _SubTodoList({
    required this.currentFocusIndex,
    required this.isDone,
  });

  final ValueNotifier<int?> currentFocusIndex;
  final ValueNotifier<bool> isDone;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parent = ref.watch(selectedThreadProvider)!;
    final provider =
        subTodosProvider(parentId: parent.id, isDone: isDone.value);
    final subTodos = ref.watch(provider);

    return subTodos.when(
      data: (todos) {
        return AnimatedReorderableList(
          key: Key(
            'sub_todo_list_${isDone.value}',
          ),
          items: todos,
          padding: EdgeInsets.symmetric(horizontal: context.appSpacing.small),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
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
          onReorder: ref.read(provider.notifier).reorder,
          isSameItem: (oldItem, newItem) => oldItem.id == newItem.id,
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
