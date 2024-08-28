part of 'thread_view.dart';

class _ThreadHeader extends HookConsumerWidget {
  const _ThreadHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(selectedThreadProvider);
    if (item == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(height: context.appSpacing.medium),
        switch (item) {
          AppChatItem(:final message, :final createdAt) =>
            ChatAndOgpListItem.threadTop(
              message: message,
              createdAt: createdAt,
            ),
          AppTodoItem() => _Todo(
              todoItem: item,
            ),
          _ => throw UnimplementedError(),
        },
      ],
    );
  }
}

class _Todo extends HookConsumerWidget {
  const _Todo({
    required this.todoItem,
  });

  final AppTodoItem todoItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController =
        useTextEditingController(text: todoItem.title);

    useEffect(
      () {
        textEditingController.text = todoItem.title;
        return null;
      },
      [todoItem.title],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TodoListItem(
        key: ValueKey(todoItem.id),
        isDone: todoItem.isDone,
        textEditingController: textEditingController,
        // TODO: threadControllerがリアルタイム更新されるようになったら
        // onToggleDoneを実装する。
        // onToggleDone: (value) {
        //   ref
        //       .read(todoControllerProvider.notifier)
        //       .toggleTodoDone(todoId: id);
        //   FirebaseAnalytics.instance.logEvent(
        //     name: AnalyticsEventName.toggleTodoDone.name,
        //   );
        // },
      ),
    );
  }
}
