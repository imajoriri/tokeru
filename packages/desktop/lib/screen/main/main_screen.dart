import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/screen/main/thread/thread_view.dart';
import 'package:tokeru_desktop/screen/main/todo/todo_view.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_widgets/widgets.dart';

class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threadOpen = ref.watch(selectedThreadProvider) != null;
    final threadWidth = useState(500.0);

    final maxWidth = MediaQuery.of(context).size.width - 200;
    const minWidth = 300.0;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chat
          const Expanded(
            child: Column(
              children: [
                Expanded(
                  child: _PanelContainer(
                    child: TodoView(),
                  ),
                ),
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
            _PanelContainer(
              width: threadWidth.value,
              child: const ThreadView(),
            ),
          ],
        ],
      ),
    );
  }
}

class _PanelContainer extends StatelessWidget {
  const _PanelContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
  });

  final Widget child;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}

class _Divider extends HookWidget {
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
    // 外側のDividerの幅
    const dividerWidth = 10.0;

    // borderの幅
    const borderWidth = 4.0;
    // borderの高さ
    const borderHeight = 60.0;

    final hovered = useState(false);

    final border = Container(
      width: isVertical ? borderWidth : borderHeight,
      height: isVertical ? borderHeight : borderWidth,
      decoration: BoxDecoration(
        color: hovered.value
            ? context.appColors.outlineStrong
            // 色を変えたい場合に残しておく。
            : context.appColors.outlineStrong.withOpacity(0),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return MouseRegion(
      cursor: _getCursor(),
      onEnter: (_) => hovered.value = true,
      onExit: (_) => hovered.value = false,
      child: GestureDetector(
        onVerticalDragUpdate: onVerticalDragUpdate,
        onHorizontalDragUpdate: onHorizontalDragUpdate,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: isVertical ? dividerWidth : double.infinity,
          height: isVertical ? double.infinity : dividerWidth,
          child: isVertical
              ? Column(
                  children: [
                    const Spacer(),
                    border,
                    const Spacer(),
                  ],
                )
              : Row(
                  children: [
                    const Spacer(),
                    border,
                    const Spacer(),
                  ],
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
}
