import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/memo/memo_controller.dart';
import 'package:quick_flutter/controller/method_channel/method_channel_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/controller/todo_text_field_focus/todo_text_field_focus_controller.dart';
import 'package:quick_flutter/model/analytics_event/analytics_event_name.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/actions/delete_todo/delete_todo_action.dart';
import 'package:quick_flutter/widget/actions/focus_down/focus_down_action.dart';
import 'package:quick_flutter/widget/actions/focus_up/focus_up_action.dart';
import 'package:quick_flutter/widget/actions/move_down_todo/move_down_todo_action.dart';
import 'package:quick_flutter/widget/actions/move_up_todo/move_up_todo_action.dart';
import 'package:quick_flutter/widget/actions/toggle_todo_done/toggle_todo_done_action.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';
import 'package:quick_flutter/widget/shortcutkey.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:super_hot_key/super_hot_key.dart';

part 'screen.g.dart';
part 'todo_list.dart';
part 'memo.dart';

@Riverpod(keepAlive: true)
class BookmarkController extends _$BookmarkController {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

class TextFieldScreen extends HookConsumerWidget {
  TextFieldScreen({super.key});

  final largeWindowKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(methodChannelProvider);
    final bookmark = ref.watch(bookmarkControllerProvider);

    HotKey.create(
      definition: HotKeyDefinition(
        key: PhysicalKeyboardKey.comma,
        shift: true,
        meta: true,
      ),
      onPressed: () {
        final channel = ref.read(methodChannelProvider);
        channel.invokeMethod(AppMethodChannel.openOrClosePanel.name);
      },
    );

    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'inactive':
          if (!bookmark) {
            channel.invokeMethod(
              AppMethodChannel.closeWindow.name,
            );
          } else {
            FocusScope.of(context).unfocus();
          }
          break;
      }
      return null;
    });

    return Material(
      child: SingleChildScrollView(
        child: NotificationListener<SizeChangedLayoutNotification>(
          onNotification: (notification) {
            // サイズが変更されたことを検知した時の処理
            ref.read(methodChannelProvider).invokeMethod(
              AppMethodChannel.setFrameSize.name,
              {"height": largeWindowKey.currentContext?.size?.height},
            );
            return true;
          },
          child: SizeChangedLayoutNotifier(
            child: _LargeWindow(
              key: largeWindowKey,
              onBuildCallback: () {
                ref.read(methodChannelProvider).invokeMethod(
                  AppMethodChannel.setFrameSize.name,
                  {
                    "height": largeWindowKey.currentContext?.size?.height,
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _LargeWindow extends HookConsumerWidget {
  const _LargeWindow({Key? key, this.onBuildCallback}) : super(key: key);

  /// ビルド後に呼ばれるコールバック
  final Function? onBuildCallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onBuildCallback?.call();
        });
        return null;
      },
      const [],
    );

    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 4, right: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Header(),
          const TodoList(),

          const _TodoTextField(),

          // 初期リリースでは非表示
          // _MemoScreen(),
        ],
      ),
    );
  }
}

/// 新規Todoを追加するためのTextField
class _TodoTextField extends HookConsumerWidget {
  const _TodoTextField({Key? key}) : super(key: key);

  /// todoを最後に追加し、テキストを空にする
  void _addTodo(
    WidgetRef ref,
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    final lastIndex = ref.read(todoControllerProvider).valueOrNull?.length;
    ref
        .read(todoControllerProvider.notifier)
        .add(lastIndex ?? 0, title: controller.text);
    controller.clear();
    ref.read(memoControllerProvider.notifier).updateContent('');

    FirebaseAnalytics.instance.logEvent(
      name: AnalyticsEventName.addTodo.name,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSubmit = useState(false);
    final baseOffset = useState(0);

    final controller = useTextEditingController();
    final focusNode = ref.watch(todoTextFieldFocusControllerProvider);

    useEffect(
      () {
        controller.addListener(() {
          canSubmit.value = controller.text.isNotEmpty;
          baseOffset.value = controller.selection.baseOffset;
        });

        return null;
      },
      [],
    );

    // Memoの読み込み時毎回データをセットしているとリビルドされてフォーカスが外れてしまうため
    // 初回のみmemoの値をセットする
    final setInitValue = useState(false);
    useEffect(
      () {
        ref.listen(memoControllerProvider, (previous, next) {
          if (next.hasValue && !setInitValue.value) {
            final memo = next.valueOrNull!;
            controller.text = memo.content;
            setInitValue.value = true;
          }
        });

        return null;
      },
      [],
    );

    return Actions(
      actions: {
        // カーソルがテキストの一番最初にある場合のみ、フォーカスを一つ上に移動する
        if (baseOffset.value == 0)
          FocusUpIntent: ref.read(todoFucusLastActionProvider),
      },
      child: CallbackShortcuts(
        bindings: <ShortcutActivator, VoidCallback>{
          const SingleActivator(LogicalKeyboardKey.enter, meta: true): () {
            if (canSubmit.value) {
              _addTodo(ref, controller, focusNode);
            }
          },
        },
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a new todo or memo...',
                  ),
                  onChanged: (text) {
                    ref
                        .read(memoControllerProvider.notifier)
                        .updateContent(text);
                  },
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                color: context.colorScheme.primary,
                onPressed: canSubmit.value
                    ? () {
                        _addTodo(ref, controller, focusNode);
                      }
                    : null,
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(methodChannelProvider);
    final bookmark = ref.watch(bookmarkControllerProvider);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              IconButton(
                focusNode: FocusNode(skipTraversal: true),
                tooltip: ShortcutActivatorType.closeWindow.longLabel,
                onPressed: () {
                  channel.invokeMethod(
                    AppMethodChannel.openOrClosePanel.name,
                  );
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        // Dragできるようなアイコン
        const MouseRegion(
          cursor: SystemMouseCursors.grabbing,
          child: Icon(
            Icons.drag_indicator_outlined,
            color: Colors.grey,
          ),
        ),
        // 右がわのアイコン
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                focusNode: FocusNode(skipTraversal: true),
                onPressed: () {
                  ref.read(bookmarkControllerProvider.notifier).toggle();
                  if (!ref.read(bookmarkControllerProvider)) {
                    channel.invokeMethod(
                      AppMethodChannel.closeWindow.name,
                    );
                  }
                },
                tooltip: ShortcutActivatorType.pinWindow.longLabel,
                icon: Icon(
                  bookmark ? Icons.push_pin : Icons.push_pin_outlined,
                ),
                color: bookmark
                    ? context.colorScheme.primary
                    : context.colorScheme.secondary,
              ),
              // 不要なので一旦消す
              // IconButton(
              //   focusNode: FocusNode(skipTraversal: true),
              //   tooltip: 'Move the window to the opposite side',
              //   onPressed: () {
              //     channel.invokeMethod(
              //       AppMethodChannel.switchHorizen.name,
              //     );
              //   },
              //   icon: const Icon(Icons.compare_arrows_rounded),
              // ),
              IconButton(
                focusNode: FocusNode(skipTraversal: true),
                tooltip: ShortcutActivatorType.newTodo.longLabel,
                onPressed: () async {
                  await ref.read(todoControllerProvider.notifier).add(0);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ref
                        .read(todoFocusControllerProvider.notifier)
                        .requestFocus(0);
                  });

                  await FirebaseAnalytics.instance.logEvent(
                    name: AnalyticsEventName.addTodo.name,
                  );
                },
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
