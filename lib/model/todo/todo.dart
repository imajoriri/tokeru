import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick_flutter/systems/timestamp_converter.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@Freezed(unionKey: 'type')
sealed class TodoItem with _$TodoItem {
  @FreezedUnionValue('todo')
  const factory TodoItem.todo({
    required String id,
    required String title,
    required bool isDone,
    required int indentLevel,
    required int index,
    @TimestampConverter() required DateTime createdAt,
  }) = Todo;

  @FreezedUnionValue('divider')
  const factory TodoItem.divider({
    required String id,
    required int index,
    @TimestampConverter() required DateTime createdAt,
  }) = TodoDivider;

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    if (json['type'] == '' || json['type'] == null) {
      return Todo.fromJson(json);
    }
    return _$TodoItemFromJson(json);
  }
}
