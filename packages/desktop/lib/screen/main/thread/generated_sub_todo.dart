part of 'thread_view.dart';

/// 生成されたサブタスクを表示するWidget。
class _GeneratedSubTodo extends HookConsumerWidget {
  const _GeneratedSubTodo();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parent = ref.watch(selectedThreadProvider) as AppTodoItem;
    final provider = generativeSubTodoProvider(parentTodoTitle: parent.title);

    final currentFocusIndex = useState<int?>(null);

    return ref.watch(provider).when(
      data: (todos) {
        if (todos.isEmpty) {
          return const SizedBox();
        }

        return FocusScope(
          child: Column(
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
                  // todosを追加した際にリビルドされて欲しいためtodos.lengthを使用する
                  final key =
                      Key('generated_sub_todo_${index}_${todos.length}');

                  return HookBuilder(
                    key: key,
                    builder: (context) {
                      final focusNode = useFocusNode();
                      if (currentFocusIndex.value == index) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          focusNode.requestFocus();
                          currentFocusIndex.value = null;
                        });
                      }
                      return TodoListItem.generatedAi(
                        context: context,
                        focusNode: focusNode,
                        textEditingController:
                            useTextEditingController(text: todos[index]),
                        onDeleted: () {
                          ref.read(provider.notifier).delete(index: index);
                          currentFocusIndex.value = index > 0 ? index - 1 : 0;
                        },
                        onUpdatedTitle: (value) {
                          ref
                              .read(provider.notifier)
                              .updateTitle(index: index, title: value);
                        },
                        focusDown: FocusScope.of(context).nextFocus,
                        focusUp: FocusScope.of(context).previousFocus,
                        onNewTodoBelow: () async {
                          ref
                              .read(provider.notifier)
                              .addWithIndex(index: index + 1);
                          currentFocusIndex.value = index + 1;
                        },
                      );
                    },
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
                        final lastIndex = ref
                            .read(subTodosProvider(parent.id).notifier)
                            .lastIndex;
                        ref.read(provider.notifier).accept(
                              parentId: parent.id,
                              firstIndex: lastIndex + 1,
                            );
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
          ),
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
