import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/model.dart';

part 'thread.g.dart';

@riverpod
class SelectedThread extends _$SelectedThread {
  @override
  AppItem? build() {
    return null;
  }

  void open(AppItem item) {
    state = item.copyWith();
  }
}
