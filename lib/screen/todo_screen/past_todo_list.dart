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
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        final yesterdayStart =
            DateTime(yesterday.year, yesterday.month, yesterday.day);
        // 機能のTodoListItem
        final yesterdayTodo = todos.where((todo) {
          return todo.createdAt.isAfter(yesterdayStart);
        }).toList();

        final notYesterdayTodo = todos.where((todo) {
          return todo.createdAt.isBefore(yesterdayStart);
        }).toList();

        return ExpansionTile(
          title: const Text('Past Todos'),
          expandedAlignment: Alignment.topLeft,
          children: [
            Text(
              'Yesterday',
              style: context.appTextTheme.headlineMedium,
            ),
            Column(
              children: List.generate(yesterdayTodo.length, (index) {
                final todo = yesterdayTodo[index];
                return switch (todo) {
                  Todo() => TodoListItem(
                      todo: todo,
                      controller: TextEditingController(text: todo.title),
                      readOnly: true,
                    ),
                  TodoDivider() => throw UnimplementedError(),
                };
              }),
            ),
            const SizedBox(height: 8),
            Text('Older', style: context.appTextTheme.headlineMedium),
            Column(
              children: List.generate(notYesterdayTodo.length, (index) {
                final todo = notYesterdayTodo[index];
                return switch (todo) {
                  Todo() => TodoListItem(
                      todo: todo,
                      controller: TextEditingController(text: todo.title),
                      readOnly: true,
                    ),
                  TodoDivider() => throw UnimplementedError(),
                };
              }),
            ),
          ],
        );
      },
      error: (e, s) => const Text('happen somethings'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
