import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/today_app_item/today_app_item_controller.dart';
import 'package:quick_flutter/controller/todo_update/todo_update_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/widget/focus_nodes.dart';
import 'package:quick_flutter/widget/list_item/chat_list_item.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

class ChatView extends HookConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = todayAppItemControllerProvider;
    final appItems = ref.watch(provider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        appItems.when(
          data: (appItems) {
            return Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.extentAfter < 300) {
                    ref
                        .read(todayAppItemControllerProvider.notifier)
                        .fetchNext();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: appItems.length,
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final appItem = appItems[index];
                    // ignore: unnecessary_cast
                    final nextAppItem = appItems[index + 1] as AppItem?;
                    // 次のAppItemが日付が変わるかどうか。
                    final isNextDay = nextAppItem != null &&
                        appItem.createdAt.day != nextAppItem.createdAt.day;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isNextDay)
                          DayDividerItem(
                            year: appItem.createdAt.year,
                            month: appItem.createdAt.month,
                            day: appItem.createdAt.day,
                          ),
                        switch (appItem) {
                          AppTodoItem() => ChatListItem.todo(
                              todo: appItem,
                              onChangedCheck: (value) {
                                ref.read(
                                  todoUpdateControllerProvider(
                                    todo: appItem.copyWith(
                                      isDone: value ?? false,
                                    ),
                                  ).future,
                                );
                              },
                            ),
                          AppChatItem() => ChatListItem.chat(chat: appItem),
                          AppDividerItem() => throw UnimplementedError(),
                        },
                      ],
                    );
                  },
                ),
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
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: _ChatTextField(),
        ),
      ],
    );
  }
}

/// チャットのTextField。
class _ChatTextField extends HookConsumerWidget {
  const _ChatTextField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = todayAppItemControllerProvider;
    final textEditingController = useTextEditingController();
    final hasFocus = useState(false);
    final canSubmit = useState(false);

    textEditingController.addListener(() {
      canSubmit.value = textEditingController.text.isNotEmpty;
    });

    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 150));
    final colorTween = ColorTween(
      begin: context.appColors.borderDefault,
      end: context.appColors.borderStrong,
    );
    final shadowColorTween = ColorTween(
      begin: Colors.transparent,
      end: context.appColors.borderStrong.withOpacity(0.2),
    );

    return AnimatedBuilder(
      animation: animationController,
      child: CallbackShortcuts(
        bindings: <ShortcutActivator, VoidCallback>{
          const SingleActivator(LogicalKeyboardKey.enter, meta: true): () {
            if (textEditingController.text.isEmpty) return;
            ref
                .read(provider.notifier)
                .addChat(message: textEditingController.text);
            textEditingController.clear();
          },
        },
        child: Focus(
          onFocusChange: (value) {
            hasFocus.value = chatFocusNode.hasFocus;
            if (value) {
              animationController.forward();
            } else {
              animationController.reverse();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    maxLines: null,
                    focusNode: chatFocusNode,
                    style: context.appTextTheme.bodyMedium,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                _SendButton(
                  onPressed: canSubmit.value
                      ? () {
                          if (textEditingController.text.isEmpty) return;
                          ref
                              .read(provider.notifier)
                              .addChat(message: textEditingController.text);
                          textEditingController.clear();
                        }
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: colorTween.evaluate(animationController)!,
            ),
            borderRadius: BorderRadius.circular(4),
            color: context.appColors.backgroundDefault,
            boxShadow: [
              BoxShadow(
                color: shadowColorTween.evaluate(animationController)!,
                offset: const Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: child,
        );
      },
    );
  }
}

/// チャットを送信するためのButton。
class _SendButton extends HookWidget {
  final void Function()? onPressed;

  const _SendButton({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);
    final focus = useState(false);
    Color getBackgroundColor(BuildContext context) {
      if (onPressed == null) {
        return context.appColors.backgroundDisabled;
      }
      if (hover.value || focus.value) {
        return context.appColors.primaryHovered;
      }
      return context.appColors.primary;
    }

    return GestureDetector(
      onTap: onPressed,
      child: FocusableActionDetector(
        onShowHoverHighlight: (value) => hover.value = value,
        onShowFocusHighlight: (value) => focus.value = value,
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) => onPressed?.call(),
          ),
        },
        mouseCursor: onPressed != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: context.appSpacing.smallX,
            horizontal: context.appSpacing.medium,
          ),
          decoration: BoxDecoration(
            color: getBackgroundColor(context),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconTheme.merge(
            child: const Icon(Icons.send),
            data: IconThemeData(
              size: 20,
              color: context.appColors.primaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}

/// 日付を跨ぐ際の区切り線。
class DayDividerItem extends StatelessWidget {
  const DayDividerItem({
    super.key,
    required this.year,
    required this.month,
    required this.day,
  });
  // year
  final int year;
  // month
  final int month;
  // day
  final int day;

  @override
  Widget build(BuildContext context) {
    final isToday = DateTime.now().year == year &&
        DateTime.now().month == month &&
        DateTime.now().day == day;

    final text = isToday ? 'Today' : '$month/$day';
    return Row(
      children: [
        Expanded(child: Divider(color: context.appColors.borderDefault)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.appColors.borderDefault,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
          ),
        ),
        Expanded(child: Divider(color: context.appColors.borderDefault)),
      ],
    );
  }
}
