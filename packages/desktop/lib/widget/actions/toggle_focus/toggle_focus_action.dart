import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/widget/actions/custom_action.dart';
import 'package:quick_flutter/widget/focus_nodes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toggle_focus_action.g.dart';

/// TodoとChatのフォーカスを切り替える[Intent]
class ToggleFocusIntent extends Intent {
  const ToggleFocusIntent();
}

@riverpod
ToggleFocusAction toggleFocusAction(ToggleFocusActionRef ref) =>
    ToggleFocusAction(ref);

class ToggleFocusAction extends CustomAction<ToggleFocusIntent> {
  ToggleFocusAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant ToggleFocusIntent intent) async {
    if (todoViewFocusNode.hasFocus) {
      chatFocusNode.requestFocus();
    } else {
      todoViewFocusNode.requestFocus();
    }
    return null;
  }
}
