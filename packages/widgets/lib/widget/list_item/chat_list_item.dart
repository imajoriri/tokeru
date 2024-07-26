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
  });

  final String text;

  /// URLをタップした時の処理。
  final void Function(Uri)? launchUrl;

  /// Widget下部に表示するWidget。
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);
    return FocusableActionDetector(
      onShowHoverHighlight: (value) => hover.value = value,
      child: Container(
        color: hover.value
            ? context.appColors.onSurface.withOpacity(0.08)
            : context.appColors.surface,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        child: _Chat(
          message: text,
          bottomWidget: bottomWidget,
          launchUrl: launchUrl!,
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
    return SelectionArea(
      child: SizedBox(
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
              SizedBox(height: context.appSpacing.small),
              bottomWidget!,
              SizedBox(height: context.appSpacing.small),
            ],
          ],
        ),
      ),
    );
  }
}
