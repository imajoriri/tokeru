import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo.dart';
import 'package:quick_flutter/repository/memo_repository.dart';

final bookmarkProvider = FutureProvider.autoDispose<List<Memo>>((ref) async {
  return ref.watch(memoRepositoryProvider).getBookmarks();
});

final addBookmarkProvider =
    Provider.autoDispose.family<Future<void>, String>((ref, id) async {
  await ref.watch(memoRepositoryProvider).addBookmark(id);
  return;
});

final removeBookmarkProvider =
    Provider.autoDispose.family<Future<void>, String>((ref, id) async {
  await ref.watch(memoRepositoryProvider).removeBookmark(id);
  return;
});
