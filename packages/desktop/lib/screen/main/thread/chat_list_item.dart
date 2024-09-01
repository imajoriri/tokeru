part of 'thread_view.dart';

/// スレッドのチャットリスト。
class _ChatListItems extends ConsumerWidget {
  const _ChatListItems();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAppItem = ref.watch(selectedThreadProvider);
    if (selectedAppItem == null) {
      return const SizedBox.shrink();
    }

    final provider = threadsProvider(selectedAppItem.id);
    final appItems = ref.watch(provider);

    return Expanded(
      child: appItems.when(
        skipLoadingOnReload: true,
        data: (appItems) {
          return ChatListItems.thread(
            threads: appItems,
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, _) {
          return Center(
            child: Text('Error: $error'),
          );
        },
      ),
    );
  }
}
