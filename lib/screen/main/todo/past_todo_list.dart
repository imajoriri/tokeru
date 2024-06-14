part of 'todo_view.dart';

class PastTodoList extends HookConsumerWidget {
  const PastTodoList({super.key});

  /// 日付けごとにグルーピングするメソッド
  Map<DateTime, List<AppItem>> groupByDate(List<AppItem> todoItems) {
    final grouped = <DateTime, List<AppItem>>{};
    for (final item in todoItems) {
      // createdAtの時間を切り捨てた日付を取得
      final date = DateTime(
        item.createdAt.year,
        item.createdAt.month,
        item.createdAt.day,
      );
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

        return Column(
          children: groupByDate(todos).entries.map((entry) {
            final date = entry.key;
            final todos = entry.value;
            if (todos.isEmpty) {
              return const SizedBox();
            }
            // 今日との差分を取得
            final diff = today.difference(date).inDays;
            final title = diff == 1
                ? 'Yesterday'
                : '${DateFormat.yMMMd().format(date)} ($diff days ago)';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    title,
                    style: context.appTextTheme.titleSmall,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return switch (todo) {
                      AppTodoItem() => HookBuilder(
                          key: ValueKey(todo.id),
                          builder: (context) {
                            return TodoListItem(
                              todo: todo,
                              controller:
                                  useTextEditingController(text: todo.title),
                              onUpdatedTitle: (value) => ref
                                  .read(pastTodoControllerProvider.notifier)
                                  .updateTodoTitle(
                                    todoId: todo.id,
                                    title: value,
                                  ),
                              onToggleDone: (value) async {
                                ref
                                    .read(pastTodoControllerProvider.notifier)
                                    .updateIsDone(
                                      todoId: todo.id,
                                      isDone: value ?? false,
                                    );
                                FirebaseAnalytics.instance.logEvent(
                                  name: AnalyticsEventName.toggleTodoDone.name,
                                );
                              },
                              focusDown: () {
                                FocusScope.of(context).nextFocus();
                              },
                              focusUp: () {
                                FocusScope.of(context).previousFocus();
                              },
                            );
                          },
                        ),
                      AppChatItem() => throw UnimplementedError(),
                      AppDividerItem() => throw UnimplementedError(),
                    };
                  },
                  itemCount: todos.length,
                ),
              ],
            );
          }).toList(),
        );
      },
      error: (e, s) => const Text('happen somethings'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
