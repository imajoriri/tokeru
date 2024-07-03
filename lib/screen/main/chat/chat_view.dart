import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/ogp_controller/ogp_controller.dart';
import 'package:quick_flutter/controller/today_app_item/today_app_item_controller.dart';
import 'package:quick_flutter/controller/todo_add/todo_add_controller.dart';
import 'package:quick_flutter/controller/todo_update/todo_update_controller.dart';
import 'package:quick_flutter/model/analytics_event/analytics_event_name.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/widget/card/url_preview_card.dart';
import 'package:quick_flutter/widget/focus_nodes.dart';
import 'package:quick_flutter/widget/button/check_button.dart';
import 'package:quick_flutter/widget/list_item/chat_list_item.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    final isLast = index == 0;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Builder(
                          builder: (context) {
                            if (index == appItems.length - 1) {
                              return const SizedBox.shrink();
                            }
                            // ignore: unnecessary_cast
                            final nextAppItem = appItems[index + 1] as AppItem?;
                            // 次のAppItemが日付が変わるかどうか。
                            final isNextDay = nextAppItem != null &&
                                appItem.createdAt.day !=
                                    nextAppItem.createdAt.day;
                            if (isNextDay) {
                              return DayDividerItem(
                                year: appItem.createdAt.year,
                                month: appItem.createdAt.month,
                                day: appItem.createdAt.day,
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
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
                          AppChatItem() => _ChatListItemChat(appItem: appItem),
                          AppDividerItem() => throw UnimplementedError(),
                        },
                        if (isLast) const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ),
            );
          },
          loading: () {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: CupertinoActivityIndicator(),
            );
          },
          error: (error, _) {
            return Center(
              child: Text('Error: $error'),
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: _ChatTextField(),
        ),
      ],
    );
  }
}

class _ChatListItemChat extends ConsumerWidget {
  const _ChatListItemChat({
    required this.appItem,
  });

  final AppChatItem appItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final links = appItem.links;
    return ChatListItem.chat(
      chat: appItem,
      bottomWidget: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final uri = links[index];
          final asyncValue =
              ref.watch(ogpControllerProvider(url: uri.toString()));
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: asyncValue.when(
              data: (ogp) {
                return UrlPreviewCard(
                  key: UniqueKey(),
                  ogp: ogp,
                  onTap: () async {
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                );
              },
              loading: () {
                return const UrlPreviewCard.loading();
              },
              error: (error, _) {
                return const SizedBox.shrink();
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: context.appSpacing.small);
        },
        itemCount: links.length,
      ),
    );
  }
}

/// チャットのTextField。
class _ChatTextField extends HookConsumerWidget {
  const _ChatTextField();

  Future<void> _send({
    required TextEditingController textEditingController,
    required WidgetRef ref,
    required bool todoMode,
  }) async {
    if (textEditingController.text.isEmpty) return;

    // Todoモードの場合、改行でTodoを複数作成する。
    if (todoMode) {
      final titles = textEditingController.text.split('\n');
      await ref.read(
        todoAddControllerProvider(
          titles: titles,
          indexType: TodoAddIndexType.last,
        ).future,
      );
      textEditingController.clear();
      return;
    }

    final provider = todayAppItemControllerProvider;
    ref.read(provider.notifier).addChat(message: textEditingController.text);
    textEditingController.clear();
    FirebaseAnalytics.instance.logEvent(
      name: AnalyticsEventName.addChat.name,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    final hasFocus = useState(false);
    final canSubmit = useState(false);
    final todoMode = useState(false);

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
          const SingleActivator(LogicalKeyboardKey.enter, meta: true): () =>
              _send(
                textEditingController: textEditingController,
                ref: ref,
                todoMode: todoMode.value,
              ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        maxLines: null,
                        focusNode: chatFocusNode,
                        style: context.appTextTheme.bodyMedium,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: todoMode.value
                              ? 'New todo list'
                              : 'Talk to myself',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CheckButton(
                      onPressed: (_) async {
                        todoMode.value = !todoMode.value;
                      },
                      checked: todoMode.value,
                      uncheckedColor: context.appColors.iconSubtle,
                      checkedColor: context.appColors.primary,
                    ),
                    const Spacer(),
                    _SendButton(
                      onPressed: canSubmit.value
                          ? () => _send(
                                textEditingController: textEditingController,
                                ref: ref,
                                todoMode: todoMode.value,
                              )
                          : null,
                    ),
                  ],
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(
            vertical: context.appSpacing.smallX,
            horizontal: context.appSpacing.small,
          ),
          decoration: BoxDecoration(
            color: getBackgroundColor(context),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconTheme.merge(
            child: const Icon(Icons.send),
            data: IconThemeData(
              size: 16,
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
