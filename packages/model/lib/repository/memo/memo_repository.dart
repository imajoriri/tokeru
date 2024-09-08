import 'package:riverpod/riverpod.dart';
import 'package:tokeru_model/model.dart';
import 'package:tokeru_model/repository/firebase/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'memo_repository.g.dart';

@riverpod
MemoRepository memoRepository(MemoRepositoryRef ref) =>
    MemoRepository(ref: ref);

class MemoRepository {
  MemoRepository({
    required this.ref,
  });
  final Ref ref;

  Future<Memo> fetchMemo({required String userId}) async {
    final result = await ref.read(userDocumentProvider(userId)).get();
    if (result.exists) {
      final data = result.data() as Map<String, dynamic>;
      final content = data["content"] as String?;
      return Memo(content: content ?? '');
    }
    return const Memo(content: '');
  }

  Future<void> updateMemo({
    required Memo memo,
    required String userId,
  }) async {
    await ref.read(userDocumentProvider(userId)).set({'content': memo.content});
  }
}
