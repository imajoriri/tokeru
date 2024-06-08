import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick_flutter/systems/timestamp_converter.dart';

part 'chat.freezed.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required String id,
    required String todoId,
    required String body,
    @TimestampConverter() required DateTime createdAt,
  }) = _Chat;
}
