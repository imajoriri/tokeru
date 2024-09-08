part of 'thread_view.dart';

/// 画面下部のチャットテキストフィールド。
class _ChatTextField extends ConsumerWidget {
  const _ChatTextField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: ChatTextField.chat(
        focusNode: threadViewFocusNode,
        onSubmit: (message) async {
          final selectedAppItem = ref.watch(selectedThreadProvider);
          if (selectedAppItem == null) {
            return;
          }
          final provider = threadChatsProvider(selectedAppItem.id);
          ref.read(provider.notifier).add(message: message);
        },
      ),
    );
  }
}
