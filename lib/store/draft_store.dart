import 'package:quick_flutter/model/draft.dart';
import 'package:quick_flutter/repository/draft_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'draft_store.g.dart';

@riverpod
class DraftStore extends _$DraftStore {
  @override
  FutureOr<List<Draft>> build() async {
    final drafts =
        await ref.read(draftRepositoryProvider).getAll(descending: false);
    return drafts;
  }

  Future<void> addDraft(String content) async {
    if (content.isEmpty) return;
    final draft = await ref.read(draftRepositoryProvider).add(content: content);
    state = AsyncValue.data(
      [
        ...state.valueOrNull ?? [],
        draft,
      ],
    );
  }

  Future<void> removeDraft(int index) async {
    final draftId = state.valueOrNull?[index].id;
    await ref.read(draftRepositoryProvider).delete(id: draftId!);
    final drafts = <Draft>[...state.valueOrNull ?? []];
    drafts.removeAt(index);
    state = AsyncValue.data(drafts);
  }

  Future<void> updateDraft({
    required String id,
    required String content,
  }) async {
    await ref.read(draftRepositoryProvider).update(id: id, content: content);
  }
}
