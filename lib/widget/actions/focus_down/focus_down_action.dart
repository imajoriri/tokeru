import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';

/// フォーカスを下に移動する[Intent]
class FocusDownIntent extends Intent {
  const FocusDownIntent();
}

final todoFocusDownActionProvider = Provider((ref) => TodoFocusDownAction(ref));

/// Todoのフォーカスを下に移動する[Action]
class TodoFocusDownAction extends Action<FocusDownIntent> {
  TodoFocusDownAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant FocusDownIntent intent) {
    final focusController = ref.read(todoFocusControllerProvider.notifier);
    if (focusController.getFocusIndex() == -1) {
      ref.read(todoFocusControllerProvider.notifier).requestFocus(0);
      return null;
    }
    ref.read(todoFocusControllerProvider.notifier).focusNext();
    return null;
  }
}
