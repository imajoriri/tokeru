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
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        channel.invokeMethod(
                            AppMethodChannel.openOrClosePanel.name);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              // Dragできるようなアイコン
              const MouseRegion(
                cursor: SystemMouseCursors.grabbing,
                child: Icon(Icons.drag_indicator_outlined),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          channel
                              .invokeMethod(AppMethodChannel.windowToLeft.name);
                        },
                        icon: const Icon(Icons.arrow_circle_left_outlined)),
                    IconButton(
                      onPressed: () {
                        ref.read(bookmarkControllerProvider.notifier).toggle();
                      },
                      tooltip: 'Window does not shrink when inactive',
                      icon: Icon(
                          bookmark ? Icons.push_pin : Icons.push_pin_outlined),
                      color: bookmark
                          ? context.colorScheme.primary
                          : context.colorScheme.secondary,
                    ),
                    IconButton(
                        onPressed: () {
                          channel.invokeMethod(
                              AppMethodChannel.windowToRight.name);
                        },
                        icon: const Icon(Icons.arrow_circle_right_outlined)),
                  ],
                ),
              ),
            ],
          ),
          const TodoList(),
          // 初期リリースでは非表示
          // _MemoScreen(),
        ],
      ),
    );
  }
}
