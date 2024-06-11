import 'package:flutter/material.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_text_editing_controller.g.dart';

/// Todoリストの[Text]を管理するProvider
@riverpod
class TodoTextEditingController extends _$TodoTextEditingController {
  @override
  TextEditingController build(String todoId) {
    // watchするとtodoControllerProviderの変更時に毎回TextEditingController
    // が生成されてしまうため、ref.readで参照する
    final todos = ref.read(todoControllerProvider);
    final todo = todos.valueOrNull
        ?.whereType<AppTodoItem>()
        .firstWhere((element) => element.id == todoId);
    final controller = TextEditingController(text: todo?.title ?? '');
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  }
}
