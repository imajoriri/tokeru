import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo.freezed.dart';

@freezed
class Memo with _$Memo {
  const factory Memo({
    required String deltaJson,
  }) = _Memo;
}
