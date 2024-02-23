part of 'screen.dart';

class _LargeWindow extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(methodChannelProvider);
    final bookmark = ref.watch(bookmarkControllerProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, left: 4, right: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    channel.invokeMethod(AppMethodChannel.windowToLeft.name);
                  },
                  icon: const Icon(Icons.arrow_circle_left_outlined)),
              IconButton(
                onPressed: () {
                  ref.read(bookmarkControllerProvider.notifier).toggle();
                },
                icon: Icon(bookmark ? Icons.bookmark : Icons.bookmark_outline),
                color: bookmark
                    ? context.colorScheme.primary
                    : context.colorScheme.secondary,
              ),
              IconButton(
                  onPressed: () {
                    channel.invokeMethod(AppMethodChannel.windowToRight.name);
                  },
                  icon: const Icon(Icons.arrow_circle_right_outlined)),
            ],
          ),
          const TodoList(),
          _MemoScreen(),
        ],
      ),
    );
  }
}
