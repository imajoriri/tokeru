part of 'thread_view.dart';

/// 生成されたサブタスクを表示するWidget。
class _GeneratedSubTodo extends HookConsumerWidget {
  const _GeneratedSubTodo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parent = ref.watch(selectedThreadProvider) as AppTodoItem;
    final provider = generativeSubTodoProvider(parentTodoTitle: parent.title);
    return ref.watch(provider).when(
      data: (todos) {
        if (todos.isEmpty) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: todos.length,
              physics: const NeverScrollableScrollPhysics(),
              padding:
                  EdgeInsets.symmetric(horizontal: context.appSpacing.small),
              separatorBuilder: (context, index) {
                return SizedBox(height: context.appSpacing.smallX);
              },
              itemBuilder: (context, index) {
                return TodoListItem.generatedAi(
                  textEditingController:
                      TextEditingController(text: todos[index]),
                  context: context,
                );
              },
            ),
            FilledButton(
              onPressed: () {
                ref.read(provider.notifier).accept(parentId: parent.id);
              },
              child: const Text('Accept'),
            ),
          ],
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
