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
part 'large_window.dart';
part 'small_window.dart';
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
    final windowSizeMode = ref.watch(windowSizeModeControllerProvider);
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

    ref.listen(windowSizeModeControllerProvider, (previous, next) {
      final _ = switch (next) {
        // TODO: ここもビルド後にする??
        WindowSizeMode.small => {
            ref.read(methodChannelProvider).invokeMethod(
              AppMethodChannel.setFrameSize.name,
              {"height": 50},
            ),
          },
        // .largeになるときは `_LargeWindow` のコールバックでサイズを変えるので不要
        WindowSizeMode.large => {},
      };
    });

    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'inactive':
          if (!bookmark) {
            ref.read(windowSizeModeControllerProvider.notifier).toSmall();
          }
          break;
      }
      return null;
    });

    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            switch (windowSizeMode) {
              WindowSizeMode.small => _SmallWindow(),
              WindowSizeMode.large =>
                NotificationListener<SizeChangedLayoutNotification>(
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
                            "height":
                                largeWindowKey.currentContext?.size?.height,
                          },
                        );
                      },
                    ), // サイズ変更を監視したいウィジェット
                  ),
                ),
            },
          ],
        ),
      ),
    );
  }
}
