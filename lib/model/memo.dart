import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo.freezed.dart';

@freezed
abstract class Memo with _$Memo {
  const factory Memo({
    required String id,
    required String content,
    required DateTime createdAt,
    required bool isBookmark,
  }) = _Memo;
}
