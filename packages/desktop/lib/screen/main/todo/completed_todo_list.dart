part of 'todo_view.dart';

class CompletedTodoList extends HookConsumerWidget {
  const CompletedTodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(completedTodosProvider);

    return todos.when(
      data: (todos) {
        if (todos.isEmpty) {
          return const SizedBox.shrink();
        }
        return ListView.builder(
          itemCount: todos.length,
          padding: EdgeInsets.symmetric(horizontal: context.appSpacing.medium),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final todo = todos[index];
            final key = ValueKey(todos[index].id);
            return HookBuilder(
              key: key,
              builder: (context) {
                final textEditingController =
                    useTextEditingController(text: todo.title);
                return TodoListItem.completed(
                  textEditingController: textEditingController,
                  onToggleDone: (value) {
                    ref
                        .read(completedTodosProvider.notifier)
                        .toggleTodoDone(todoId: todo.id);
                  },
                );
              },
            );
          },
        );
      },
      error: (e, s) => const Text('Error'),
      loading: () => const SizedBox.shrink(),
    );
  }
}
