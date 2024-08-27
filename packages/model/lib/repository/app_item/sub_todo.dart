part of 'app_item_repository.dart';

/// [AppSubTodoItem]を扱うRepository
extension AppSubTodoItemRepository on AppItemRepository {
  /// 追加とソートを同時に行う。
  ///
  /// - [addedTodo] 追加するTodo
  /// - [todos] 並び順を更新するTodo
  Future<void> addSubTodoAndUpdateOrder({
    required String userId,
    required AppSubTodoItem addedTodo,
    required List<AppSubTodoItem> todos,
  }) async {
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

  /// サブTodoの並び順を一括で更新する
  Future<void> updateSubTodoOrder({
    required String userId,
    required List<AppSubTodoItem> todos,
  }) async {
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
}
