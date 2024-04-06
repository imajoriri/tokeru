import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_text_field_focus_controller.g.dart';

/// Todo作成用のTextFieldのフォーカスを管理する[FocusNode]のProvider
@riverpod
FocusNode todoTextFieldFocusController(TodoTextFieldFocusControllerRef ref) {
  final node = FocusNode();
  ref.onDispose(() {
    node.dispose();
  });
  return node;
}
