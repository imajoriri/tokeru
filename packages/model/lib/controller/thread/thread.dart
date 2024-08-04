import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'thread.g.dart';
part 'thread.freezed.dart';

@freezed
class Thread with _$Thread {
  const factory Thread({
    required String chatId,
    required String message,
  }) = _Thread;
}

@riverpod
class SelectedThread extends _$SelectedThread {
  @override
  Thread? build() {
    return null;
  }

  void setThread({
    required String chatId,
    required String message,
  }) {
    state = Thread(
      chatId: chatId,
      message: message,
    );
  }
}
