part of 'todo_view.dart';

class DoneTodoList extends HookConsumerWidget {
  const DoneTodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todayDoneTodoControllerProvider).valueOrNull ?? [];
    return ListView.builder(
      itemCount: todos.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final todo = todos[index];
        return HookBuilder(
          key: ValueKey(todo.id),
          builder: (context) {
            return switch (todo) {
              Todo() => TodoListItem(
                  todo: todo,
                  controller: useTextEditingController(text: todo.title),
                  readOnly: true,
                ),
              TodoDivider() => throw UnimplementedError(),
            };
          },
        );
      },
    );
  }
}
