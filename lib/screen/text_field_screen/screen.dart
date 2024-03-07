import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/memo/memo_controller.dart';
import 'package:quick_flutter/controller/method_channel/method_channel_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/window_size_mode/window_size_mode_controller.dart';
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
    final channel = ref.watch(methodChannelProvider);
    final bookmark = ref.watch(bookmarkControllerProvider);
    // final windowSizeMode = ref.watch(windowSizeModeControllerProvider);

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
          // if (windowSizeMode == WindowSizeMode.large)
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    IconButton(
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
                child: Icon(Icons.drag_indicator_outlined),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        channel
                            .invokeMethod(AppMethodChannel.windowToLeft.name);
                      },
                      icon: const Icon(Icons.arrow_circle_left_outlined),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(bookmarkControllerProvider.notifier).toggle();
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
                      onPressed: () {
                        channel.invokeMethod(
                          AppMethodChannel.windowToRight.name,
                        );
                      },
                      icon: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const TodoList(),

          // 初期リリースでは非表示
          // _MemoScreen(),
        ],
      ),
    );
  }
}
