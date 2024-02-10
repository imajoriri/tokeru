import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/memo/memo.dart';
import 'package:quick_flutter/repository/memo/memo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'memo_controller.g.dart';

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
    if (user.valueOrNull == null) {
      return const Memo(deltaJson: "");
    }
    memoRepository = ref.read(memoRepositoryProvider(user.value!.id));
    return await memoRepository!.fetchMemo();
  }

  Future<void> updateDeltaJson(String deltaJson) async {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }
    assert(state.valueOrNull != null, "state.valueOrNull is null");

    final memo = state.valueOrNull!.copyWith(deltaJson: deltaJson);

    if (memoRepository == null) {
      return;
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // NOTE: stateを更新してしまうと、再度buildが走ってしまうため、stateを更新しない
      memoRepository!.updateMemo(memo);
    });
  }
}
