import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo.dart';
import 'package:quick_flutter/repository/memo_repository.dart';

final addMemoProvider =
    Provider.autoDispose.family<Future<void>, String>((ref, content) async {
  ref.watch(memoRepositoryProvider).add(content);
  return;
});

final memosProvider = FutureProvider.autoDispose<List<Memo>>((ref) {
  return ref.watch(memoRepositoryProvider).getAll();
});

class UpdateMemoParams {
  UpdateMemoParams({
    required this.id,
    this.content,
    this.isBookmark,
  });
  final String id;
  final String? content;
  final bool? isBookmark;
}

final updateMemoContentProvider = Provider.autoDispose
    .family<Future<void>, UpdateMemoParams>((ref, params) async {
  ref.watch(memoRepositoryProvider).update(
      id: params.id, content: params.content, isBookmark: params.isBookmark);
  return;
});
