import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo.dart';
import 'package:quick_flutter/systems/firebase_provider.dart';

final memoRepositoryProvider = Provider((ref) => MemoRepository(ref: ref));

class MemoRepository {
  MemoRepository({required this.ref});
  final Ref ref;

  Future<void> add({required String content, bool isBookmark = false}) async {
    // 追加する処理
    final firestore = ref.read(firestoreProvider);
    await firestore.collection("memos").add({
      "content": content,
      "createdAt": DateTime.now(),
      "isBookmark": isBookmark,
    });
  }

  // 更新
  Future<void> update(
      {required String id, String? content, bool? isBookmark}) async {
    final firestore = ref.read(firestoreProvider);
    // null以外を更新
    final data = {
      if (content != null) "content": content,
      if (isBookmark != null) "isBookmark": isBookmark,
    };
    await firestore.collection("memos").doc(id).update(data);
  }

  Future<List<Memo>> getAll() async {
    final firestore = ref.read(firestoreProvider);
    final response = await firestore
        .collection("memos")
        .orderBy('createdAt', descending: true)
        .get();
    return (response.docs.map((doc) {
      return Memo(
        id: doc.id,
        content: doc.data()['content'] ?? '',
        isBookmark: doc.data()['isBookmark'] ?? false,
        createdAt: doc.data()['createdAt'].toDate() ?? DateTime.now(),
      );
    }).toList());
  }

  Future<List<Memo>> getBookmarks() async {
    final firestore = ref.read(firestoreProvider);
    final response = await firestore
        .collection("memos")
        .where("isBookmark", isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .get();
    return (response.docs.map((doc) {
      return Memo(
        id: doc.id,
        content: doc.data()['content'] ?? '',
        isBookmark: doc.data()['isBookmark'] ?? false,
        createdAt: doc.data()['createdAt'].toDate() ?? DateTime.now(),
      );
    }).toList());
  }

  Future<void> addBookmark(String id) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.collection("memos").doc(id).update({
      "isBookmark": true,
    });
  }

  Future<void> removeBookmark(String id) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.collection("memos").doc(id).update({
      "isBookmark": false,
    });
  }
}
