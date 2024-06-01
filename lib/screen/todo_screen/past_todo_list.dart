part of 'todo_screen.dart';

class PastTodoList extends HookConsumerWidget {
  const PastTodoList({super.key});

  /// 日付けごとにグルーピングするメソッド
  Map<DateTime, List<TodoItem>> groupByDate(List<TodoItem> todoItems) {
    final grouped = <DateTime, List<TodoItem>>{};
    for (final item in todoItems) {
      // createdAtの時間を切り捨てた日付を取得
      final date = DateTime(
          item.createdAt.year, item.createdAt.month, item.createdAt.day);
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(item);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(pastTodoControllerProvider);

    return todos.when(
      data: (todos) {
        if (todos.isEmpty) {
          return const SizedBox();
        }

        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        return ListTileTheme.merge(
          dense: true,
          contentPadding: const EdgeInsets.only(left: 12),
          horizontalTitleGap: 4,
          child: ExpansionTile(
            title: Text('Past Todos', style: context.appTextTheme.titleSmall),
            controlAffinity: ListTileControlAffinity.leading,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: groupByDate(todos).entries.map((entry) {
              final date = entry.key;
              final todos = entry.value;
              if (todos.isEmpty) {
                return const SizedBox();
              }
              // 今日との差分を取得
              final diff = today.difference(date).inDays;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "${DateFormat.yMMMd().format(date)} ($diff days ago)",
                      style: context.appTextTheme.titleSmall,
                    ),
                  ),
                  Column(
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
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
      error: (e, s) => const Text('happen somethings'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
