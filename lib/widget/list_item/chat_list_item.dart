import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

class ChatListItem extends HookWidget {
  const ChatListItem._({
    required this.app,
    this.onChangedCheck,
  });

  factory ChatListItem.chat({required AppChatItem chat}) =>
      ChatListItem._(app: chat);

  factory ChatListItem.todo({
    required AppTodoItem todo,
    required void Function(bool?)? onChangedCheck,
  }) =>
      ChatListItem._(
        app: todo,
        onChangedCheck: onChangedCheck,
      );

  final AppItem app;
  final void Function(bool?)? onChangedCheck;

  @override
  Widget build(BuildContext context) {
    final focus = useState(false);
    final hover = useState(false);
    return FocusableActionDetector(
      onShowFocusHighlight: (value) => focus.value = value,
      onShowHoverHighlight: (value) => hover.value = value,
      child: Container(
        color: hover.value || focus.value
            ? context.appColors.backgroundHovered
            : context.appColors.backgroundDefault,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        child: switch (app) {
          AppChatItem(:final message) => SizedBox(
              width: double.infinity,
              child: SelectableText(
                message,
                style: context.appTextTheme.bodyMedium,
              ),
            ),
          AppTodoItem(:final title, :final isDone) => Row(
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: CupertinoCheckbox(
                      value: isDone,
                      activeColor: context.appColors.backgroundChecked,
                      onChanged: onChangedCheck!,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SelectableText(
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
            ),
          AppDividerItem() => throw UnimplementedError(),
        },
      ),
    );
  }
}
