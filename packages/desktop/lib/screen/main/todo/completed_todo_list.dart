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
            return HookBuilder(
              builder: (context) {
                final textEditingController =
                    useTextEditingController(text: todo.title);
                return TodoListItem(
                  isDone: todo.isDone,
                  index: index,
                  textEditingController: textEditingController,
                  subTodoCount: todo.subTodoCount,
                  onDeleted: () async {
                    ref
                        .read(todosProvider.notifier)
                        .deleteTodo(todoId: todo.id);
                  },
                  onToggleDone: (value) {
                    ref
                        .read(todosProvider.notifier)
                        .toggleTodoDone(todoId: todo.id);
                    FirebaseAnalytics.instance.logEvent(
                      name: AnalyticsEventName.toggleTodoDone.name,
                    );
                  },
                );
              },
            );
          },
        );
      },
      error: (e, s) => const Text('Error'),
      loading: () => const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Loading...'),
      ),
    );
  }
}
