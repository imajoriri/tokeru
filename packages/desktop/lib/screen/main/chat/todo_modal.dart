part of 'chat_view.dart';

class _TodoModal extends HookWidget {
  const _TodoModal();

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    // ウィンドウサイズによって変化させる。
    final max = MediaQuery.of(context).size.height * 0.75;

    return FocusScope(
      node: todoViewFocusNode,
      child: MouseRegion(
        onEnter: (_) {
          isHovered.value = true;
          TokeruHaptics().hovered();
        },
        onExit: (_) {
          isHovered.value = false;
        },
        child: Container(
          constraints: BoxConstraints(maxHeight: max),
          decoration: BoxDecoration(
            color: context.appColors.surface,
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                spreadRadius: 0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedSize(
            alignment: Alignment.topCenter,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutExpo,
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    _TodoList(
                      hovered: isHovered.value,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TodoList extends HookConsumerWidget {
  const _TodoList({
    required this.hovered,
  });

  /// ホバーしているかどうか。
  final bool hovered;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoControllerProvider);
    return todos.when(
      data: (todos) {
        if (todos.isEmpty) {
          return const _EmptyState();
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            const _Header(),

            // TodoList
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ReorderableListView.builder(
                buildDefaultDragHandles: false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: hovered ? todos.length : 1,
                onReorder: (oldIndex, newIndex) {
                  // NOTE: なぜか上から下に移動するときはnewIndexが1つずれるので
                  // その分を補正する
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  ref
                      .read(todoControllerProvider.notifier)
                      .reorder(oldIndex, newIndex);
                },
                itemBuilder: (context, index) {
                  final key = ValueKey(todos[index].id);
                  final todo = todos[index];
                  return _TodoListItem(
                    key: key,
                    todo: todo,
                    index: index,
                    onFocus: () {
                      ref.read(selectedThreadProvider.notifier).open(todo.id);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
      error: (e, s) => const Text('Error'),
      loading: () => const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Loading...'),
      ),
    );
  }
}

class _TodoListItem extends HookConsumerWidget {
  const _TodoListItem({
    super.key,
    required this.todo,
    required this.index,
    required this.onFocus,
  });

  final AppTodoItem todo;
  final int index;
  final Function() onFocus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.appSpacing.smallX),
      child: TodoListItem(
        isDone: todo.isDone,
        onOpenThread: () {
          ref.read(selectedThreadProvider.notifier).open(todo.id);
        },
        index: index,
        title: todo.title,
        threadCount: todo.threadCount,
        onDeleted: () async {
          ref.read(todoControllerProvider.notifier).deleteTodo(todoId: todo.id);
        },
        onUpdatedTitle: (value) {
          ref
              .read(todoControllerProvider.notifier)
              .updateTodoTitle(todoId: todo.id, title: value);
        },
        onToggleDone: (value) {
          ref
              .read(todoControllerProvider.notifier)
              .toggleTodoDone(todoId: todo.id);
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
        onNewTodoBelow: () async {
          await ref
              .read(todoControllerProvider.notifier)
              .addTodoWithIndex(index: index + 1);
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            FocusScope.of(context).nextFocus();
          });
        },
        // 一番上のTodoは上に移動できない
        onSortUp: index != 0
            ? () {
                ref
                    .read(todoControllerProvider.notifier)
                    .reorder(index, index - 1);
              }
            : null,
        // 一番下のTodoは下に移動できない
        onSortDown:
            index != ref.read(todoControllerProvider).valueOrNull!.length - 1
                ? () {
                    ref
                        .read(todoControllerProvider.notifier)
                        .reorder(index, index + 1);
                  }
                : null,
      ),
    );
  }
}

class _EmptyState extends ConsumerWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: Actions.handler<NewTodoIntent>(
        context,
        const NewTodoIntent(),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              'There are no To-Dos for today.\nPlease start by clicking here or pressing Command + N.',
              style: context.appTextTheme.bodySmall.copyWith(
                color: context.appColors.onSurfaceSubtle,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            AppTextButton.medium(
              onPressed: () {
                ref
                    .read(todoControllerProvider.notifier)
                    .addTodoWithIndex(index: 0);
              },
              text: const Text('Add To-Do'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Row(
        children: [
          Text(
            "To-Dos",
            style: context.appTextTheme.titleSmall,
          ),
          SizedBox(width: context.appSpacing.small),
          AppIconButton.medium(
            icon: const Icon(Icons.add),
            tooltip: ShortcutActivatorType.newTodo.longLabel,
            onPressed: () async {
              await ref
                  .read(todoControllerProvider.notifier)
                  .addTodoWithIndex(index: 0);
              await FirebaseAnalytics.instance.logEvent(
                name: AnalyticsEventName.addTodo.name,
              );
            },
          ),
        ],
      ),
    );
  }
}
