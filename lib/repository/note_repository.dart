import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/note.dart';
import 'package:quick_flutter/systems/firebase_provider.dart';

final noteRepositoryProvider = Provider((ref) => NoteRepository(ref: ref));

class NoteRepository {
  NoteRepository({required this.ref});
  final Ref ref;

  Future<Note> add({required String content}) async {
    final firestore = ref.read(firestoreProvider);
    final res = await firestore.collection("notes").add({
      "content": content,
      "createdAt": DateTime.now(),
    });
    return Note(
      id: res.id,
      content: content,
      createdAt: DateTime.now(),
    );
  }

  Future<List<Note>> getAll({
    bool descending = true,
  }) async {
    final firestore = ref.read(firestoreProvider);
    final response = await firestore
        .collection("notes")
        .orderBy('createdAt', descending: descending)
        .get();
    return (response.docs.map((doc) {
      return Note(
        id: doc.id,
        content: doc.data()['content'] ?? '',
        createdAt: doc.data()['createdAt'].toDate() ?? DateTime.now(),
      );
    }).toList());
  }

  // 更新
  Future<void> update({required String id, String? content}) async {
    final firestore = ref.read(firestoreProvider);
    // null以外を更新
    final data = {
      if (content != null) "content": content,
    };
    await firestore.collection("notes").doc(id).update(data);
  }

  // 削除
  Future<void> remove(String id) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.collection("notes").doc(id).delete();
  }

  // 一括削除し、1つだけから文字で追加
  Future<void> clear() async {
    final firestore = ref.read(firestoreProvider);
    final batch = firestore.batch();
    final response = await firestore.collection("notes").get();
    for (final doc in response.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
