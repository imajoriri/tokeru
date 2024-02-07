import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    required bool isDone,
    required int indentLevel,
    required int index,
    required DateTime createdAt,
  }) = _Todo;
}
