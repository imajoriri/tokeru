import 'dart:async';

import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/memo/memo.dart';
import 'package:quick_flutter/repository/memo/memo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'memo_controller.g.dart';

/// Userに紐づく[Memo]を返すController
///
/// ユーザーがログインしていない場合は、[Memo]は空の状態で返す。
@Riverpod(keepAlive: true)
class MemoController extends _$MemoController {
  Timer? _debounceTimer;
  MemoRepository? memoRepository;

  @override
  FutureOr<Memo> build() async {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    final user = ref.watch(userControllerProvider);
    if (user.hasError || user.valueOrNull == null) {
      return const Memo(content: "");
    }
    memoRepository = ref.read(memoRepositoryProvider(user.value!.id));
    return await memoRepository!.fetchMemo();
  }

  Future<void> updateContent(String content) async {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }
    assert(state.valueOrNull != null, "state.valueOrNull is null");

    final memo = state.valueOrNull!.copyWith(content: content);

    if (memoRepository == null) {
      return;
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // NOTE: stateを更新してしまうと、再度buildが走ってしまうため、stateを更新しない
      memoRepository!.updateMemo(memo);
      state = AsyncData(memo.copyWith(content: content));
    });
  }
}
