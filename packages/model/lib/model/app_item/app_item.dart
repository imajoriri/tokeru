import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tokeru_model/systems/regexp.dart';
import 'package:tokeru_model/systems/timestamp_converter.dart';

part 'app_item.freezed.dart';
part 'app_item.g.dart';

@Freezed(unionKey: 'type')
sealed class AppItem with _$AppItem {
  @FreezedUnionValue('chat')
  const factory AppItem.chat({
    /// ID。
    required String id,

    /// メッセージ。
    required String message,

    /// 作成日時。
    @TimestampConverter() required DateTime createdAt,
  }) = AppChatItem;

  @FreezedUnionValue('thread')
  const factory AppItem.thread({
    /// ID。
    required String id,

    /// メッセージ。
    required String message,

    /// 親の[AppItem.id]ID。
    required String parentId,

    /// 作成日時。
    @TimestampConverter() required DateTime createdAt,
  }) = AppThreadItem;

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
