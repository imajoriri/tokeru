import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:tokeru_widgets/widgets.dart';

class ChatListItem extends HookWidget {
  const ChatListItem.chat({
    super.key,
    required this.text,
    required this.launchUrl,
    this.threadCount = 0,
    this.bottomWidget,
    this.onRead,
    this.onThread,
    this.onConvertTodo,
  });

  final String text;

  /// URLをタップした時の処理。
  final void Function(Uri)? launchUrl;

  /// スレッドの件数。
  final int threadCount;

  /// Widget下部に表示するWidget。
  final Widget? bottomWidget;

  /// 既読ボタンを押した時の処理。
  final void Function()? onRead;

  /// スレッドを押した時の処理。
  final void Function()? onThread;

  /// Todoへの変換を押した時の処理。
  final void Function()? onConvertTodo;

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);
    final tooltipController = OverlayPortalController();
    final link = LayerLink();
    return FocusableActionDetector(
      onShowHoverHighlight: (value) {
        hover.value = value;
        tooltipController.toggle();
      },
      child: CompositedTransformTarget(
        link: link,
        child: OverlayPortal(
          controller: tooltipController,
          overlayChildBuilder: (context) {
            return Align(
              child: CompositedTransformFollower(
                link: link,
                targetAnchor: Alignment.topRight,
                followerAnchor: Alignment.center,
                offset: const Offset(-60, 0),
                child: MouseRegion(
                  onEnter: (event) {
                    hover.value = true;
                    tooltipController.show();
                  },
                  onExit: (event) {
                    hover.value = false;
                    tooltipController.hide();
                  },
                  child: _ChatActionButtons(
                    onRead: onRead,
                    onThread: onThread,
                    onConvertTodo: onConvertTodo,
                  ),
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: hover.value
                  ? context.appColors.onSurface.withOpacity(0.08)
                  : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Chat(
                  message: text,
                  bottomWidget: bottomWidget,
                  launchUrl: launchUrl!,
                ),
                if (threadCount != 0) ...[
                  SizedBox(height: context.appSpacing.smallX),
                  _ThreadButton(
                    threadCount: threadCount,
                    onThread: onThread,
                    chatHovered: hover.value,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatActionButtons extends StatelessWidget {
  const _ChatActionButtons({
    required this.onRead,
    required this.onThread,
    required this.onConvertTodo,
  });

  final void Function()? onRead;
  final void Function()? onThread;
  final void Function()? onConvertTodo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.surface,
        border: Border.all(
          color: context.appColors.outline,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onRead != null) ...[
            AppIconButton.small(
              icon: const Icon(CupertinoIcons.eye),
              onPressed: onRead!,
              tooltip: "Mark as read",
              bounce: false,
            ),
            SizedBox(width: context.appSpacing.smallX),
          ],
          if (onThread != null) ...[
            AppIconButton.small(
              icon: const Icon(CupertinoIcons.chat_bubble_text),
              onPressed: onThread!,
              tooltip: "Thread",
              bounce: false,
            ),
            SizedBox(width: context.appSpacing.smallX),
          ],
          if (onConvertTodo != null) ...[
            AppIconButton.small(
              icon: const Icon(CupertinoIcons.checkmark_alt_circle),
              onPressed: onConvertTodo!,
              tooltip: "Convert to Todo",
              bounce: false,
            ),
          ],
        ],
      ),
    );
  }
}

class _Chat extends StatelessWidget {
  const _Chat({
    required this.message,
    required this.launchUrl,
    this.bottomWidget,
  });

  final String message;
  final Widget? bottomWidget;
  final void Function(Uri) launchUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Linkify(
            onOpen: (link) async {
              launchUrl(Uri.parse(link.url));
            },
            options: const LinkifyOptions(humanize: false),
            text: message,
            style: context.appTextTheme.bodyMedium,
            linkStyle: context.appTextTheme.bodyMedium.copyWith(
              color: context.appColors.link,
              decoration: TextDecoration.none,
            ),
          ),
          if (bottomWidget != null) ...[
            bottomWidget!,
          ],
        ],
      ),
    );
  }
}

class _ThreadButton extends StatelessWidget {
  const _ThreadButton({
    required this.threadCount,
    required this.onThread,
    required this.chatHovered,
  });

  final int threadCount;
  final void Function()? onThread;
  final bool chatHovered;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = chatHovered
        ? context.appColors.surface.hovered
        : context.appColors.surface;
    return SelectionContainer.disabled(
      child: AppButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        onPressed: onThread,
        contentColor: context.appColors.link,
        backgroundColor: backgroundColor,
        bounce: false,
        backgroundColorAnimated: false,
        // ホバー時などのカラーは、チャットのホバーとかぶってしまうので、
        // 意図的に指定している。
        hoveredColor: context.appColors.surface,
        focusedColor: context.appColors.surface,
        pressedColor: context.appColors.surface,
        child: Container(
          padding: EdgeInsets.all(context.appSpacing.smallX),
          width: double.infinity,
          child: Text(
            '$threadCount replies',
            style: context.appTextTheme.labelMidium.copyWith(
              color: context.appColors.link,
            ),
          ),
        ),
      ),
    );
  }
}
