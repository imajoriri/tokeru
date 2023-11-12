import 'package:freezed_annotation/freezed_annotation.dart';

part 'draft.freezed.dart';

@freezed
abstract class Draft with _$Draft {
  const factory Draft({
    required String id,
    required String content,
    required DateTime createdAt,
  }) = _Draft;
}
