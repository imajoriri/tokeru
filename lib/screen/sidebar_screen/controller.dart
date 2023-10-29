import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick_flutter/model/memo.dart';
import 'package:quick_flutter/store/bookmark_store.dart';
import 'package:quick_flutter/store/memo_store.dart';
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

  void close() {
    state = state.copyWith(
      isShow: false,
    );
  }

  void update({required String content}) {
    ref.read(updateMemoContentProvider(
      UpdateMemoParams(
        id: state.memo!.id,
        content: content,
      ),
    ));
    ref.invalidate(memosProvider);
    ref.invalidate(bookmarkProvider);
  }
}
