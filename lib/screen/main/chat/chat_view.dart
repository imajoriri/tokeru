import 'package:collection/collection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/ogp_controller/ogp_controller.dart';
import 'package:quick_flutter/controller/read/read_controller.dart';
import 'package:quick_flutter/controller/app_item/app_item_controller.dart';
import 'package:quick_flutter/controller/read_all/read_all_controller.dart';
import 'package:quick_flutter/controller/todo_update/todo_update_controller.dart';
import 'package:quick_flutter/model/analytics_event/analytics_event_name.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/widget/button/submit_button.dart';
import 'package:quick_flutter/widget/card/url_preview_card.dart';
import 'package:quick_flutter/widget/focus_nodes.dart';
import 'package:quick_flutter/widget/list_item/chat_list_item.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

part 'chat_list.dart';
part 'chat_text_field.dart';

class ChatView extends HookConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _ChatList(),
              _ReadButton(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: _ChatTextField(),
        ),
      ],
    );
  }
}

class _ReadButton extends ConsumerWidget {
  const _ReadButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readAll = ref.watch(readAllProvider);
    return readAll.when(
      skipLoadingOnReload: true,
      data: (value) {
        if (value) {
          return const SizedBox.shrink();
        }
        return Positioned(
          bottom: context.appSpacing.small,
          child: ElevatedButton(
            onPressed: () => ref
                .read(readControllerProvider.notifier)
                .markAsRead(DateTime.now()),
            child: const Text('Mark as read'),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, _) => const SizedBox.shrink(),
    );
  }
}
