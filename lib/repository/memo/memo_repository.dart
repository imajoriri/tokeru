import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo/memo.dart';
import 'package:quick_flutter/repository/firebase/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'memo_repository.g.dart';

@riverpod
MemoRepository memoRepository(MemoRepositoryRef ref, String userId) =>
    MemoRepository(ref: ref, userId: userId);

class MemoRepository {
  MemoRepository({
    required this.ref,
    required this.userId,
  });
  final Ref ref;
  final String userId;

  Future<Memo> fetchMemo() async {
    final result = await ref.read(userDocumentProvider(userId)).get();
    if (result.exists) {
      final data = result.data() as Map<String, dynamic>;
      final content = data["deltaJson"] as String?;
      return Memo(deltaJson: content ?? '');
    }
    return const Memo(deltaJson: '');
  }

  Future<void> updateMemo(Memo memo) async {
    await ref
        .read(userDocumentProvider(userId))
        .set({'deltaJson': memo.deltaJson});
  }
}
