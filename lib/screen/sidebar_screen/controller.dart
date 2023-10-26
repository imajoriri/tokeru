import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick_flutter/model/memo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controller.freezed.dart';
part 'controller.g.dart';

@freezed
class SidebarScreenState with _$SidebarScreenState {
  factory SidebarScreenState({
    @Default(false) bool isShow,
    Memo? memo,
  }) = _SidebarScreenState;
}

@riverpod
class SidebarScreenController extends _$SidebarScreenController {
  @override
  SidebarScreenState build() {
    return SidebarScreenState();
  }

  void open({required Memo memo}) {
    state = state.copyWith(
      isShow: true,
      memo: memo,
    );
  }
}
