import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick_flutter/systems/timestamp_converter.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    required bool isDone,
    required int indentLevel,
    required int index,
    @TimestampConverter() required DateTime createdAt,
  }) = _Todo;
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
