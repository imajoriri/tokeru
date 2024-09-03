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
        // if (todos.isEmpty) {
        //   return const SizedBox();
        // }

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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.appSpacing.small,
                vertical: context.appSpacing.smallX,
              ),
              child: Row(
                children: [
                  AppTextButton.small(
                    icon: const Icon(CupertinoIcons.check_mark),
                    text: const Text('Accept'),
                    onPressed: () {
                      ref.read(provider.notifier).accept(parentId: parent.id);
                    },
                    buttonType: AppTextButtonType.filled,
                  ),
                  const SizedBox(width: 8),
                  AppTextButton.small(
                    icon: const Icon(CupertinoIcons.xmark),
                    text: const Text('Reject'),
                    onPressed: () {
                      ref.read(provider.notifier).reject();
                    },
                  ),
                ],
              ),
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
