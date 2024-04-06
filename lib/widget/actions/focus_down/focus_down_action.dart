import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/controller/todo_text_field_focus/todo_text_field_focus_controller.dart';

/// フォーカスを下に移動する[Intent]
class FocusDownIntent extends Intent {
  const FocusDownIntent();
}

final todoFocusDownActionProvider = Provider((ref) => TodoFocusDownAction(ref));

/// Todoのフォーカスを下に移動する[Action]
///
/// フォーカスがない場合は最初のTodoにフォーカスを当てる。
/// 一番最後のTodoの場合は、TextFieldにフォーカスを当てる。
class TodoFocusDownAction extends Action<FocusDownIntent> {
  TodoFocusDownAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant FocusDownIntent intent) {
    final focusController = ref.read(todoFocusControllerProvider.notifier);

    // フォーカスがない場合は最初のTodoにフォーカスを当てる
    if (focusController.getFocusIndex() == -1) {
      ref.read(todoFocusControllerProvider.notifier).requestFocus(0);
      return null;
    }

    // 一番最後のTodoの場合は、TextFieldにフォーカスを当てる
    if (focusController.getFocusIndex() ==
        ref.read(todoFocusControllerProvider).length - 1) {
      ref.read(todoTextFieldFocusControllerProvider).requestFocus();
      return null;
    }

    ref.read(todoFocusControllerProvider.notifier).focusNext();
    return null;
  }
}
