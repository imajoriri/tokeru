import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tokeru_model/repository/firebase/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/model.dart';

part 'app_item_repository.g.dart';

const _collectionName = 'todos';

// TODO: リファクタリング
// - AppItemのサブクラスごとにリポジトリを分けたい。
// - userIdをメソッドごとに受け取りたい。

/// [AppItem]を扱うRepository
@riverpod
AppItemRepository appItemRepository(AppItemRepositoryRef ref, String userId) =>
    AppItemRepository(ref: ref, userId: userId);

class AppItemRepository {
  AppItemRepository({
    required this.ref,
    required this.userId,
  });
  final Ref ref;
  final String userId;

  /// [AppItem.id]から[AppItem]を取得する。
  Future<AppItem?> fetchById({
    required String userId,
    required String id,
  }) async {
    final response = await ref
        .read(userDocumentProvider(userId))
        .collection(_collectionName)
        .doc(id)
        .get();
    if (!response.exists) {
      return null;
    }
    return AppItem.fromJson(response.data()!..['id'] = response.id);
  }

  /// [AppItem]のクエリ。
  Query<Map<String, dynamic>> query({
    required String userId,
    List<String> type = const [],
    String? parentId,
    bool? isDone,
  }) {
    var query = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection(_collectionName)
        .orderBy('createdAt', descending: true);
    if (type.isNotEmpty) {
      query = query.where('type', whereIn: type);
    }
    if (parentId != null) {
      query = query.where('parentId', isEqualTo: parentId);
    }
    if (isDone != null) {
      query = query.where('isDone', isEqualTo: isDone);
    }

    return query;
  }

  /// [AppItem]を追加する。
  Future<AppItem> add(AppItem item) async {
    final json = item.toJson();
    await ref
        .read(userDocumentProvider(userId))
        .collection(_collectionName)
        .doc(item.id)
        .set(json);
    return item;
  }

  /// [AppItem]を複数追加する。
  Future<void> addAll(List<AppItem> items) async {
    final firestore = ref.read(firestoreProvider);
    final batch = firestore.batch();
    for (final item in items) {
      final json = item.toJson();
      batch.set(
        ref
            .read(userDocumentProvider(userId))
            .collection(_collectionName)
            .doc(item.id),
        json,
      );
    }
    await batch.commit();
  }

  Future<void> update<T extends AppItem>({
    required T item,
  }) async {
    final json = item.toJson();
    await ref
        .read(userDocumentProvider(userId))
        .collection(_collectionName)
        .doc(item.id)
        .update(json);
  }

  /// スレッドの件数を+1する。
  Future<void> incrementThreadCount({required String id}) async {
    await ref
        .read(userDocumentProvider(userId))
        .collection(_collectionName)
        .doc(id)
        .update({
      'threadCount': FieldValue.increment(1),
    });
  }

  /// Todoを削除する
  Future<void> delete({required String id}) async {
    await ref
        .read(userDocumentProvider(userId))
        .collection(_collectionName)
        .doc(id)
        .delete();
  }

  /// 並び順を更新する
  ///
  /// [todos]の順番で 'index' を一気に更新する
  Future<void> updateTodoOrder({required List<AppTodoItem> todos}) async {
    final firestore = ref.read(firestoreProvider);
    final batch = firestore.batch();

    for (final todo in todos) {
      batch.update(
          ref
              .read(userDocumentProvider(userId))
              .collection(_collectionName)
              .doc(todo.id),
          {
            'index': todo.index,
          });
    }
    await batch.commit();
  }

  /// 追加とソートを同時に行う。
  Future<void> addAndUpdateOrder(
      {required AppTodoItem addedTodo,
      required List<AppTodoItem> todos}) async {
    final firestore = ref.read(firestoreProvider);
    final batch = firestore.batch();

    // todoを追加する。
    batch.set(
      ref
          .read(userDocumentProvider(userId))
          .collection(_collectionName)
          .doc(addedTodo.id),
      addedTodo.toJson(),
    );

    // 並び順を更新する。
    for (final todo in todos) {
      batch.update(
          ref
              .read(userDocumentProvider(userId))
              .collection(_collectionName)
              .doc(todo.id),
          {
            'index': todo.index,
          });
    }

    await batch.commit();
  }
}
