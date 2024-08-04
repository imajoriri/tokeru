import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/model.dart';

part 'thread.g.dart';

@riverpod
class SelectedThread extends _$SelectedThread {
  @override
  AppChatItem? build() {
    return null;
  }

  void setThread({
    required AppChatItem chat,
  }) {
    state = chat.copyWith();
  }
}
