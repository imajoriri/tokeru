import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_text_editing_controller.g.dart';

/// Todoリストの[Text]を管理するProvider
@riverpod
class TodoTextEditingController extends _$TodoTextEditingController {
  @override
  List<TextEditingController> build() {
    ref.listen(todoControllerProvider, (previous, next) {
      // watchを使うと、Todoのtitleが変わった時にも発火してしまい
      // textEditControllerが更新されてカーソル位置が先頭に移動してしまうため、todo一覧取得にはreadを使い、
      // 数の差分、もしくはソートに変更があった時のみinvalidateする。
      if (previous?.value?.length != next.value?.length) {
        ref.invalidateSelf();
      }

      final previousIds = previous?.value?.map((e) => e.id).toList();
      final nextIds = next.value?.map((e) => e.id).toList();
      if (!listEquals(previousIds, nextIds)) {
        ref.invalidateSelf();
      }
    });

    // todoの数の変化以外で更新されたくないので、readを使う
    final todo = ref.read(todoControllerProvider);

    final textEditingControllers = List.generate(
      todo.valueOrNull?.length ?? 0,
      (index) => TextEditingController(text: todo.valueOrNull![index].title),
    );

    ref.onDispose(() {
      for (var c in textEditingControllers) {
        c.dispose();
      }
    });
    return textEditingControllers;
  }
}
