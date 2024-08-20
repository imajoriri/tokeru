import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/screen/main/thread/thread_view.dart';
import 'package:tokeru_desktop/screen/main/chat/chat_view.dart';
import 'package:tokeru_desktop/screen/main/todo/todo_view.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_widgets/widgets.dart';

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threadOpen = ref.watch(selectedThreadProvider) != null;
    final todoHeight = useState(300.0);
    final threadWidth = useState(500.0);

    final maxHeight = MediaQuery.of(context).size.height - 100;
    const minHeight = 100.0;
    final maxWidth = MediaQuery.of(context).size.width - 200;
    const minWidth = 300.0;
    return Scaffold(
      backgroundColor: context.appColors.surface,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chat
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: todoHeight.value,
                  child: const TodoView(),
                ),
                _Divider(
                  isVertical: false,
                  onVerticalDragUpdate: (event) {
                    final newHeight = todoHeight.value + event.delta.dy;
                    if (newHeight >= minHeight && newHeight <= maxHeight) {
                      todoHeight.value = newHeight;
                    }
                  },
                ),
                const Expanded(child: ChatView()),
              ],
            ),
          ),

          if (threadOpen) ...[
            _Divider(
              onHorizontalDragUpdate: (event) {
                // 右側のpanelにwidthを指定しているのでプラスではなくマイナスにしている。
                final newWidth = threadWidth.value - event.delta.dx;
                if (newWidth >= minWidth && newWidth <= maxWidth) {
                  threadWidth.value = newWidth;
                }
              },
            ),
            SizedBox(
              width: threadWidth.value,
              child: const ThreadView(),
            ),
          ],
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    this.isVertical = true,
    this.onVerticalDragUpdate,
    this.onHorizontalDragUpdate,
  });

  final bool isVertical;
  final void Function(DragUpdateDetails)? onVerticalDragUpdate;
  final void Function(DragUpdateDetails)? onHorizontalDragUpdate;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: _getCursor(),
      child: GestureDetector(
        onVerticalDragUpdate: onVerticalDragUpdate,
        onHorizontalDragUpdate: onHorizontalDragUpdate,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: _getPadding(),
          child: Container(
            width: isVertical ? 3 : double.infinity,
            height: isVertical ? double.infinity : 3,
            margin: _getMargin(context),
            decoration: BoxDecoration(
              color: context.appColors.outline,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  SystemMouseCursor _getCursor() {
    return isVertical
        ? SystemMouseCursors.resizeLeftRight
        : SystemMouseCursors.resizeUpDown;
  }

  EdgeInsets _getPadding() {
    return EdgeInsets.symmetric(
      vertical: isVertical ? 0 : 2,
      horizontal: isVertical ? 2 : 0,
    );
  }

  EdgeInsets _getMargin(BuildContext context) {
    return isVertical
        ? EdgeInsets.symmetric(vertical: context.appSpacing.small)
        : EdgeInsets.symmetric(horizontal: context.appSpacing.small);
  }
}
