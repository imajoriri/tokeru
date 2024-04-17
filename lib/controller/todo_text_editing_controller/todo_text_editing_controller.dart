import 'package:flutter/material.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_text_editing_controller.g.dart';

/// Todoリストの[Text]を管理するProvider
@riverpod
class TodoTextEditingController extends _$TodoTextEditingController {
  @override
  TextEditingController build(Todo todo) {
    final controller = TextEditingController(text: todo.title);
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  }
}
