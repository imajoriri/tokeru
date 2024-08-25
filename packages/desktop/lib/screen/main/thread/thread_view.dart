import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/widget/chat_and_ogp_list_item.dart';
import 'package:tokeru_desktop/widget/focus_nodes.dart';
import 'package:tokeru_desktop/widget/list_items/chat_list_items.dart';
import 'package:tokeru_desktop/widget/text_field/chat_text_field.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_model/controller/threads/threads.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_widgets/widgets.dart';

class ThreadView extends HookConsumerWidget {
  const ThreadView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(selectedThreadProvider);
    // スレッドが選択されていない場合は何も表示しない。
    if (item == null) {
      return const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(
            'No todo selected',
          ),
        ),
      );
    }

    final provider = threadsProvider(item);
    final appItems = ref.watch(provider);
    final switchValue = useState(false);

    return Column(
      children: [
        _ThreadHeader(item: item),
        if (appItems.valueOrNull?.isNotEmpty == true) ...[
          const SizedBox(height: 8),
          const _HeaderDivider(),
        ],
        const SizedBox(height: 8),
        Flexible(
          child: appItems.when(
            skipLoadingOnReload: true,
            data: (appItems) {
              return ChatListItems.thread(
                threads: appItems,
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
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Switch.adaptive(
                value: switchValue.value,
                onChanged: (value) {
                  switchValue.value = value;
                },
              ),
              ChatTextField(
                focusNode: threadViewFocusNode,
                onSubmit: (message) async {
                  if (switchValue.value) {
                    await ref.read(provider.notifier).sendMessageToAi(message);
                    return;
                  }
                  ref.read(provider.notifier).add(message: message);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThreadHeader extends ConsumerWidget {
  final AppItem item;

  const _ThreadHeader({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: context.appSpacing.medium,
            right: context.appSpacing.medium,
            top: context.appSpacing.medium,
            bottom: context.appSpacing.small,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text('Thread', style: context.appTextTheme.titleMedium),
              ),
              // close button
              AppIconButton.medium(
                icon: const Icon(Icons.close),
                onPressed: () {
                  ref.read(selectedThreadProvider.notifier).close();
                },
                tooltip: 'Close',
              ),
            ],
          ),
        ),
        switch (item) {
          AppChatItem(:final message, :final createdAt) =>
            ChatAndOgpListItem.threadTop(
              message: message,
              createdAt: createdAt,
            ),
          AppTodoItem(:final isDone, :final title) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TodoListItem(
                key: ValueKey(item.id),
                isDone: isDone,
                title: title,
                // TODO: threadControllerがリアルタイム更新されるようになったら
                // onToggleDoneを実装する。
                // onToggleDone: (value) {
                //   ref
                //       .read(todoControllerProvider.notifier)
                //       .toggleTodoDone(todoId: id);
                //   FirebaseAnalytics.instance.logEvent(
                //     name: AnalyticsEventName.toggleTodoDone.name,
                //   );
                // },
              ),
            ),
          _ => throw UnimplementedError(),
        },
      ],
    );
  }
}

class _HeaderDivider extends StatelessWidget {
  const _HeaderDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Text(
          'memo',
          style: context.appTextTheme.labelSmall.copyWith(
            color: context.appColors.onSurfaceSubtle,
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Divider(
            height: 1,
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
