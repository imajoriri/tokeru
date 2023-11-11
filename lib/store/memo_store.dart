import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quick_flutter/model/memo.dart';
import 'package:quick_flutter/repository/memo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'memo_store.freezed.dart';
part 'memo_store.g.dart';

@freezed
class MemoState with _$MemoState {
  const factory MemoState({
    @Default([]) List<Memo> memos,
    @Default([]) List<Memo> bookmarks,
  }) = _MemoState;
}

@riverpod
class MemoStore extends _$MemoStore {
  @override
  FutureOr<MemoState> build() async {
    // 今日の0時の時間を取得
    final now = DateTime.now();
    DateTime startAt = DateTime(now.year, now.month, now.day);
    DateTime endAt = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final memos = await ref
        .watch(memoRepositoryProvider)
        .getAll(startAt: startAt, endAt: endAt, descending: true);

    final bookmarks = await ref.watch(memoRepositoryProvider).getBookmarks();
    return MemoState(memos: memos, bookmarks: bookmarks);
  }

  Future<void> addMemo({
    required String content,
    required bool isBookmark,
  }) async {
    final res = await ref
        .read(memoRepositoryProvider)
        .add(content: content, isBookmark: isBookmark);
    state = AsyncValue.data(state.value!.copyWith(
      memos: [
        res,
        ...state.valueOrNull?.memos ?? [],
      ],
      bookmarks: [
        if (isBookmark) res,
        ...state.valueOrNull?.bookmarks ?? [],
      ],
    ));
  }

  Future<void> updateMemo({
    required String id,
    String? content,
    bool? isBookmark,
  }) async {
    await ref.read(memoRepositoryProvider).update(
          id: id,
          content: content,
          isBookmark: isBookmark,
        );
    state = AsyncValue.data(state.value!.copyWith(
      memos: [
        for (final memo in state.valueOrNull?.memos ?? [])
          if (memo.id == id)
            memo.copyWith(
              content: content ?? memo.content,
              isBookmark: isBookmark ?? memo.isBookmark,
            )
          else
            memo,
      ],
      bookmarks: [
        for (final memo in state.valueOrNull?.bookmarks ?? [])
          if (memo.id == id)
            memo.copyWith(
              content: content ?? memo.content,
              isBookmark: isBookmark ?? memo.isBookmark,
            )
          else
            memo,
      ],
    ));
  }

  Future<void> addBookmark(Memo memo) async {
    await ref.read(memoRepositoryProvider).addBookmark(memo.id);
    state = AsyncValue.data(state.value!.copyWith(
      memos: [
        for (final m in state.valueOrNull?.memos ?? [])
          if (m.id == memo.id) m.copyWith(isBookmark: true) else m,
      ],
      bookmarks: [
        ...state.valueOrNull?.bookmarks ?? [],
        memo,
      ],
    ));
  }

  Future<void> removeBookmark(Memo memo) async {
    await ref.read(memoRepositoryProvider).removeBookmark(memo.id);
    state = AsyncValue.data(state.value!.copyWith(
      memos: [
        for (final m in state.valueOrNull?.memos ?? [])
          if (m.id == memo.id) m.copyWith(isBookmark: false) else m,
      ],
      bookmarks: [
        for (final bookmark in state.valueOrNull?.bookmarks ?? [])
          if (bookmark.id != memo.id) bookmark,
      ],
    ));
  }
}
