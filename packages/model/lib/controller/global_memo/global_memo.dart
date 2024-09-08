import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:tokeru_model/model/memo/memo.dart';
import 'package:tokeru_model/repository/memo/memo_repository.dart';

part 'global_memo.g.dart';

/// グローバルなメモを管理するController。
@riverpod
class GlobalMemo extends _$GlobalMemo {
  @override
  FutureOr<Memo> build() async {
    final userId = ref.read(userControllerProvider).valueOrNull?.id;
    if (userId == null) {
      return const Memo(content: '');
    }
    final memo =
        await ref.read(memoRepositoryProvider).fetchMemo(userId: userId);
    return memo;
  }

  Future<void> updateMemo({required String content}) async {
    final userId = ref.read(userControllerProvider).valueOrNull?.id;
    if (userId == null) {
      return;
    }
    await ref
        .read(memoRepositoryProvider)
        .updateMemo(userId: userId, memo: Memo(content: content));
  }
}
