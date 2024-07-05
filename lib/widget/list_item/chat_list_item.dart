import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/widget/button/check_button.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatListItem extends HookWidget {
  const ChatListItem._({
    required this.app,
    this.onChangedCheck,
    this.bottomWidget,
  });

  factory ChatListItem.chat({
    required AppChatItem chat,
    Widget? bottomWidget,
  }) =>
      ChatListItem._(
        app: chat,
        bottomWidget: bottomWidget,
      );

  factory ChatListItem.todo({
    required AppTodoItem todo,
    required void Function(bool?)? onChangedCheck,
  }) =>
      ChatListItem._(
        app: todo,
        onChangedCheck: onChangedCheck,
      );

  final AppItem app;

  /// チェックボックスの状態が変更されたときのコールバック。
  final void Function(bool?)? onChangedCheck;

  /// Widget下部に表示するWidget。
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);
    return FocusableActionDetector(
      onShowHoverHighlight: (value) => hover.value = value,
      child: Container(
        color: hover.value
            ? context.appColors.backgroundHovered
            : context.appColors.backgroundDefault,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        child: switch (app) {
          AppChatItem(:final message) => _Chat(
              message: message,
              bottomWidget: bottomWidget,
            ),
          AppTodoItem(:final title, :final isDone) => _Todo(
              isDone: isDone,
              onChangedCheck: onChangedCheck,
              title: title,
            ),
          AppDividerItem() => throw UnimplementedError(),
        },
      ),
    );
  }
}

class _Chat extends StatelessWidget {
  const _Chat({
    required this.message,
    this.bottomWidget,
  });

  final String message;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      // focusNode: FocusNode(skipTraversal: true),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Linkify(
              onOpen: (link) async {
                if (!await launchUrl(Uri.parse(link.url))) {
                  throw Exception('Could not launch ${link.url}');
                }
              },
              options: const LinkifyOptions(humanize: false),
              text: message,
              style: context.appTextTheme.bodyMedium,
              linkStyle: context.appTextTheme.bodyMedium.copyWith(
                color: context.appColors.textLink,
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

class _Todo extends StatelessWidget {
  const _Todo({
    required this.isDone,
    required this.onChangedCheck,
    required this.title,
  });

  final bool isDone;
  final void Function(bool? p1)? onChangedCheck;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CheckButton(checked: isDone, onPressed: onChangedCheck!),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: context.appTextTheme.bodyMedium.copyWith(
              decoration: isDone ? TextDecoration.lineThrough : null,
              color: isDone
                  ? context.appColors.textSubtle
                  : context.appColors.textDefault,
            ),
          ),
        ),
      ],
    );
  }
}
