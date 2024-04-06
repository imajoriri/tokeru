import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/method_channel/method_channel_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'close_window_action.g.dart';

/// Windowを閉じる[Intent]
class CloseWindowIntent extends Intent {
  const CloseWindowIntent();
}

@riverpod
CloseWindowAction closeWindowAction(CloseWindowActionRef ref) =>
    CloseWindowAction(ref);

/// Windowを閉じる[Action]
class CloseWindowAction extends Action<CloseWindowIntent> {
  CloseWindowAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant CloseWindowIntent intent) async {
    final channel = ref.read(methodChannelProvider);
    channel.invokeMethod(AppMethodChannel.openOrClosePanel.name);
    return null;
  }
}
