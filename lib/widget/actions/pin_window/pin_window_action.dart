import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/screen/text_field_screen/screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pin_window_action.g.dart';

/// ウィンドウの固定をする[Intent]
class PinWindowIntent extends Intent {
  const PinWindowIntent();
}

@riverpod
PinWindowAction pinWindowAction(PinWindowActionRef ref) => PinWindowAction(ref);

/// ウィンドウの固定をする[Action]
class PinWindowAction extends Action<PinWindowIntent> {
  PinWindowAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant PinWindowIntent intent) async {
    ref.read(bookmarkControllerProvider.notifier).toggle();
    return null;
  }
}
