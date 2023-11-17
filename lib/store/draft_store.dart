import 'package:quick_flutter/model/draft.dart';
import 'package:quick_flutter/repository/draft_repository.dart';
import 'package:quick_flutter/systems/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'draft_store.g.dart';

final draftStreamStore = StreamProvider<List<Draft>>((ref) {
  final firestore = ref.read(firestoreProvider);
  return firestore
      .collection("drafts")
      .orderBy('createdAt', descending: false)
      .snapshots()
      .map((event) {
    return event.docs.map((doc) {
      return Draft(
        id: doc.id,
        content: doc.data()['content'] ?? '',
        createdAt: doc.data()['createdAt'].toDate() ?? DateTime.now(),
      );
    }).toList();
  });
});

@riverpod
class DraftController extends _$DraftController {
  @override
  void build() async {
    return null;
  }

  Future<void> addDraft(String content) async {
    if (content.isEmpty) return;
    await ref.read(draftRepositoryProvider).add(content: content);
  }

  Future<void> removeDraft(String id) async {
    await ref.read(draftRepositoryProvider).delete(id: id);
  }

  Future<void> updateDraft({
    required String id,
    required String content,
  }) async {
    await ref.read(draftRepositoryProvider).update(id: id, content: content);
  }
}
