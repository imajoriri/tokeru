import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/controller/todo_text_editing_controller/todo_text_editing_controller.dart';
import 'package:quick_flutter/controller/todo_text_field_focus/todo_text_field_focus_controller.dart';
import 'package:quick_flutter/widget/actions/custom_action.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'focus_down_action.g.dart';

/// フォーカスを下に移動する[Intent]
class FocusDownIntent extends Intent {
  const FocusDownIntent();
}

@riverpod
TodoFocusDownAction todoFocusDownAction(TodoFocusDownActionRef ref) =>
    TodoFocusDownAction(ref);

/// Todoのフォーカスを下に移動する[Action]
///
/// フォーカスがない場合は最初のTodoにフォーカスを当てる。
/// 一番最後のTodoの場合は、TextFieldにフォーカスを当てる。
class TodoFocusDownAction extends CustomAction<FocusDownIntent> {
  TodoFocusDownAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant FocusDownIntent intent) {
    final focusController = ref.read(todoFocusControllerProvider.notifier);
    final currentIndex = focusController.getFocusIndex();

    // フォーカスがない場合は最初のTodoにフォーカスを当てる
    if (currentIndex == -1) {
      ref.read(todoFocusControllerProvider.notifier).requestFocus(0);
      return null;
    }

    final textEditingController =
        ref.read(todoTextEditingControllerProvider)[currentIndex];

    if (textEditingController.value.composing.isValid) {
      return KeyEventResult.ignored;
    }

    // 現在のカーソルの位置より後に改行があるかどうか
    final isLastLine = !textEditingController.text
        .substring(textEditingController.selection.baseOffset)
        .contains('\n');
    // 最後の行にカーソルがない場合はフォーカスを移動しない
    if (!isLastLine) {
      return KeyEventResult.ignored;
    }

    // 一番最後のTodoの場合は、TextFieldにフォーカスを当てる
    if (currentIndex == ref.read(todoFocusControllerProvider).length - 1) {
      ref.read(todoTextFieldFocusControllerProvider).requestFocus();
      return null;
    }

    ref.read(todoFocusControllerProvider.notifier).focusNext();
    moveCursorToFirstLine(
      textEditingController,
      ref.read(todoTextEditingControllerProvider)[currentIndex + 1],
    );
    return null;
  }

  /// 複数行のTodoに移動した際に、一番上の行にカーソルを移動する
  void moveCursorToFirstLine(
    TextEditingController previousController,
    TextEditingController nextController,
  ) {
    final previousLastLineIndex = previousController.text.lastIndexOf('\n') + 1;
    // previouseControllerの最後の行の先頭からカーソルまでの文字数
    final previousBaseOffset =
        previousController.selection.baseOffset - previousLastLineIndex;

    final nextTextLength = nextController.text.length;

    nextController.selection = TextSelection(
      baseOffset: nextTextLength > previousBaseOffset
          ? previousBaseOffset
          : nextTextLength,
      extentOffset: nextTextLength > previousBaseOffset
          ? previousBaseOffset
          : nextTextLength,
    );
  }
}
