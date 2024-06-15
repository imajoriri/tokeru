import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick_flutter/systems/regexp.dart';
import 'package:quick_flutter/systems/timestamp_converter.dart';

part 'app_item.freezed.dart';
part 'app_item.g.dart';

@Freezed(unionKey: 'type')
sealed class AppItem with _$AppItem {
  @FreezedUnionValue('chat')
  const factory AppItem.chat({
    required String id,
    required String message,
    @TimestampConverter() required DateTime createdAt,
  }) = AppChatItem;

  @FreezedUnionValue('todo')
  const factory AppItem.todo({
    required String id,
    required String title,
    required bool isDone,
    required int index,
    @TimestampConverter() required DateTime createdAt,
  }) = AppTodoItem;

  @FreezedUnionValue('divider')
  const factory AppItem.divider({
    required String id,
    required int index,
    @TimestampConverter() required DateTime createdAt,
  }) = AppDividerItem;

  factory AppItem.fromJson(Map<String, dynamic> json) =>
      _$AppItemFromJson(json);
}

/// AppTodoItemに関する拡張メソッド
extension AppTodoItemExtension on AppTodoItem {
  /// 「@10min」のようなテキストから、分数を取得する
  int? get minutes {
    final match = timeRegExp.firstMatch(title);
    if (match == null) {
      return null;
    }
    return int.tryParse(match.group(1) ?? '');
  }
}
