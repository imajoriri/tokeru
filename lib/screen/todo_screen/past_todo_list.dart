part of 'todo_screen.dart';

class PastTodoList extends HookConsumerWidget {
  const PastTodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(pastTodoControllerProvider);

    return todos.when(
      data: (todos) {
        if (todos.isEmpty) {
          return const Text('No past todos');
        }
        return ExpansionTile(
          title: const Text('Past Todos'),
          children: List.generate(todos.length, (index) {
            final todo = todos[index];
            return switch (todo) {
              Todo() => TodoListItem(
                  todo: todo,
                  controller: TextEditingController(text: todo.title),
                  readOnly: true,
                ),
              TodoDivider() => throw UnimplementedError(),
            };
          }),
        );
      },
      error: (e, s) => const Text('happen somethings'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
