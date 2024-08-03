import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:tokeru_widgets/widgets.dart';

class ChatListItem extends HookWidget {
  const ChatListItem.chat({
    super.key,
    required this.text,
    required this.launchUrl,
    this.bottomWidget,
    this.onRead,
  });

  final String text;

  /// URLをタップした時の処理。
  final void Function(Uri)? launchUrl;

  /// Widget下部に表示するWidget。
  final Widget? bottomWidget;

  /// 既読ボタンを押した時の処理。
  final void Function()? onRead;

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
            if (onRead == null) {
              return const SizedBox.shrink();
            }
            return Align(
              child: CompositedTransformFollower(
                link: link,
                targetAnchor: Alignment.topRight,
                followerAnchor: Alignment.center,
                offset: const Offset(-40, 0),
                child: MouseRegion(
                  onEnter: (event) {
                    hover.value = true;
                    tooltipController.show();
                  },
                  onExit: (event) {
                    hover.value = false;
                    tooltipController.hide();
                  },
                  child: AppIconButton.small(
                    showBorder: true,
                    icon: const Icon(Icons.read_more),
                    onPressed: onRead!,
                    tooltip: "",
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
            child: Row(
              children: [
                Expanded(
                  child: _Chat(
                    message: text,
                    bottomWidget: bottomWidget,
                    launchUrl: launchUrl!,
                  ),
                ),
              ],
            ),
          ),
        ),
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
