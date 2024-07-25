import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/model/memo/memo.dart';
import 'package:tokeru_desktop/repository/firebase/firebase_provider.dart';
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
      final content = data["content"] as String?;
      return Memo(content: content ?? '');
    }
    return const Memo(content: '');
  }

  Future<void> updateMemo(Memo memo) async {
    await ref.read(userDocumentProvider(userId)).set({'content': memo.content});
  }
}
