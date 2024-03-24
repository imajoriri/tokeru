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
import 'package:quick_flutter/controller/window_size_mode/window_size_mode_controller.dart';
import 'package:quick_flutter/model/analytics_event/analytics_event_name.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';
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

    // 特に何もしていないが、今後何かするかもしれないので思い出しやすいように残してる。
    ref.listen(windowSizeModeControllerProvider, (previous, next) {
      final _ = switch (next) {
        WindowSizeMode.small => {},
        WindowSizeMode.large => {},
      };
    });

    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'inactive':
          FocusScope.of(context).unfocus();
          if (!bookmark) {
            ref.read(windowSizeModeControllerProvider.notifier).toSmall();
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
            ), // サイズ変更を監視したいウィジェット
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

          // 初期リリースでは非表示
          // _MemoScreen(),
        ],
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
                tooltip: 'Close',
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
              // MenuAnchor(
              //   builder: (
              //     BuildContext context,
              //     MenuController controller,
              //     Widget? child,
              //   ) {
              //     return IconButton(
              //       onPressed: () {
              //         if (controller.isOpen) {
              //           controller.close();
              //         } else {
              //           controller.open();
              //         }
              //       },
              //       icon: const Icon(Icons.more_horiz),
              //       tooltip: 'Show menu',
              //     );
              //   },
              //   menuChildren: [
              //     MenuItemButton(
              //       leadingIcon: Icon(
              //         bookmark ? Icons.push_pin : Icons.push_pin_outlined,
              //         color: bookmark
              //             ? context.colorScheme.primary
              //             : context.colorScheme.secondary,
              //       ),
              //       onPressed: () {
              //         ref.read(bookmarkControllerProvider.notifier).toggle();
              //         // ピンをONにした時は、Largeにする
              //         // OFFにした場合は、smallにし、ウィンドウ自体も非アクティブにするする。
              //         if (ref.read(bookmarkControllerProvider)) {
              //           ref
              //               .read(windowSizeModeControllerProvider.notifier)
              //               .toLarge();
              //         } else {
              //           ref
              //               .read(windowSizeModeControllerProvider.notifier)
              //               .toSmall();
              //         }
              //       },
              //       child: Text(bookmark ? 'Unpin' : 'Pin'),
              //     ),
              //   ],
              // ),
              IconButton(
                onPressed: () {
                  ref.read(bookmarkControllerProvider.notifier).toggle();
                  // ピンをONにした時は、Largeにする
                  // OFFにした場合は、smallにし、ウィンドウ自体も非アクティブにするする。
                  if (ref.read(bookmarkControllerProvider)) {
                    ref
                        .read(windowSizeModeControllerProvider.notifier)
                        .toLarge();
                  } else {
                    ref
                        .read(windowSizeModeControllerProvider.notifier)
                        .toSmall();
                  }
                },
                tooltip: 'Window does not shrink when inactive',
                icon: Icon(
                  bookmark ? Icons.push_pin : Icons.push_pin_outlined,
                ),
                color: bookmark
                    ? context.colorScheme.primary
                    : context.colorScheme.secondary,
              ),
              IconButton(
                tooltip: 'Move the window to the opposite side',
                onPressed: () {
                  channel.invokeMethod(
                    AppMethodChannel.switchHorizen.name,
                  );
                },
                icon: const Icon(Icons.compare_arrows_rounded),
              ),
              IconButton(
                tooltip: 'Add Todo',
                onPressed: () async {
                  ref.read(windowSizeModeControllerProvider.notifier).toLarge();
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
