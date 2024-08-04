part of 'chat_view.dart';

class _ChatList extends HookConsumerWidget {
  const _ChatList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(chatsProvider);

    return chats.when(
      skipLoadingOnReload: true,
      data: (chats) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.extentAfter < 300) {
              ref.read(chatsProvider.notifier).fetchNext();
            }
            return false;
          },
          child: ChatListItems(
            chats: chats,
            bottomSpace:
                ref.watch(readAllProvider).valueOrNull == true ? 0 : 32,
            readTime: ref.watch(readControllerProvider).valueOrNull,
            onRead: ref.read(readControllerProvider.notifier).markAsReadAsChat,
            onThread: (chat) {
              // TODO
            },
          ),
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
    );
  }
}
