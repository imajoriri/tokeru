part of 'thread_view.dart';

class _SubTodoView extends ConsumerWidget {
  const _SubTodoView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parent = ref.watch(selectedThreadProvider);
    if (parent == null) {
      return const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(
            'No todo selected',
          ),
        ),
      );
    }

    final provider = subTodosProvider(parent.id);
    final subTodos = ref.watch(provider);

    return subTodos.when(
      data: (todos) {
        return Padding(
          padding: EdgeInsets.only(
            left: context.appSpacing.small * 2,
            right: context.appSpacing.small,
          ),
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
              ref.read(provider.notifier).reorder(oldIndex, newIndex);
            },
            itemBuilder: (context, index) {
              final key = ValueKey(todos[index].id);
              final todo = todos[index];
              return TodoListItem(
                key: key,
                isDone: todo.isDone,
                index: index,
                title: todo.title,
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
                focusDown: () {
                  FocusScope.of(context).nextFocus();
                },
                focusUp: () {
                  FocusScope.of(context).previousFocus();
                },
                onNewTodoBelow: () async {
                  await ref.read(provider.notifier).addWithIndex(index + 1);
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    FocusScope.of(context).nextFocus();
                  });
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
          ),
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
