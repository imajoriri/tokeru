part of 'todo_view.dart';

class DoneTodoList extends HookConsumerWidget {
  const DoneTodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todayDoneTodoControllerProvider).valueOrNull ?? [];
    if (todos.isEmpty) {
      return const SizedBox();
    }
    final totalMinutes = todos
        .map((todo) => todo.minutes)
        .where((minutes) => minutes != null)
        .fold<int>(0, (prev, minutes) => prev + minutes!);
    return Column(
      children: [
        // title
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's done To-Dos @${totalMinutes}min",
                style: context.appTextTheme.titleSmall,
              ),
            ],
          ),
        ),

        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: todos.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final todo = todos[index];
            return HookBuilder(
              key: ValueKey(todo.id),
              builder: (context) {
                return TodoListItem(
                  todo: todo,
                  controller: useTextEditingController(text: todo.title),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
