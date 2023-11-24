import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';

@freezed
abstract class Note with _$Note {
  const factory Note({
    required String id,
    required String content,
    required DateTime createdAt,
  }) = _Note;
}
