import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/controller/todo_text_editing_controller/todo_text_editing_controller.dart';
import 'package:quick_flutter/widget/actions/custom_action.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'focus_up_action.g.dart';

/// フォーカスを上に移動する[Intent]
class FocusUpIntent extends Intent {
  const FocusUpIntent();
}

@riverpod
TodoFocusUpAction todoFocusUpAction(TodoFocusUpActionRef ref) =>
    TodoFocusUpAction(ref);
@riverpod
TodoFucusLastAction todoFucusLastAction(TodoFucusLastActionRef ref) =>
    TodoFucusLastAction(ref);

/// Todoのフォーカスを上に移動する[Action]
class TodoFocusUpAction extends CustomAction<FocusUpIntent> {
  TodoFocusUpAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant FocusUpIntent intent) {
    final focusController = ref.read(todoFocusControllerProvider.notifier);
    final currentIndex = focusController.getFocusIndex();

    // フォーカスがない場合は、一番下にフォーカスを移動する
    if (currentIndex == -1) {
      final todos = ref.read(todoControllerProvider).valueOrNull ?? [];
      ref
          .read(todoFocusControllerProvider.notifier)
          .requestFocus(todos.length - 1);
      return null;
    }

    final textEditingController =
        ref.read(todoTextEditingControllerProvider)[currentIndex];

    if (textEditingController.value.composing.isValid) {
      return KeyEventResult.ignored;
    }

    // TextEditingContollerのカーソルが一番上の行にいない場合は、フォーカスを移動しない
    final isFirstLine = !textEditingController.text
        .substring(0, textEditingController.selection.baseOffset)
        .contains('\n');
    if (!isFirstLine) {
      return KeyEventResult.ignored;
    }
    focusController.fucusPrevious();
    return null;
  }
}

/// Todoリストの一番下にフォーカスを移動する[Action]
class TodoFucusLastAction extends Action<FocusUpIntent> {
  TodoFucusLastAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant FocusUpIntent intent) {
    final focus = ref.read(todoFocusControllerProvider);
    if (focus.isEmpty) return null;
    ref
        .read(todoFocusControllerProvider.notifier)
        .requestFocus(focus.length - 1);
    return null;
  }
}
