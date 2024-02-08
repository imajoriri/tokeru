import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:quick_flutter/repository/firebase/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_repository.g.dart';

@riverpod
TodoRepository todoRepository(TodoRepositoryRef ref) =>
    TodoRepository(ref: ref);

class TodoRepository {
  TodoRepository({required this.ref});
  final Ref ref;

  Future<List<Todo>> fetchTodos({required String userId}) async {
    final response = await ref
        .read(userDocumentProvider(userId))
        .collection('todos')
        .where('isDone', isEqualTo: false)
        .get();
    return (response.docs.map((doc) {
      return Todo(
        id: doc.id,
        title: doc.data()['title'] ?? '',
        isDone: doc.data()['isDone'] ?? false,
        indentLevel: doc.data()['indentLevel'] ?? 0,
        index: doc.data()['index'] ?? 0,
        createdAt: doc.data()['createdAt'].toDate() ?? DateTime.now(),
      );
    }).toList());
  }

  /// Todoを追加し、idを返す
  Future<Todo> add({
    required String userId,
    String title = '',
    bool isDone = false,
    int indentLevel = 0,
    int index = 0,
  }) async {
    final createdAt = DateTime.now();
    final res =
        await ref.read(userDocumentProvider(userId)).collection("todos").add({
      'title': title,
      'isDone': isDone,
      'indentLevel': indentLevel,
      'index': index,
      'createdAt': createdAt,
    });
    return Todo(
      id: res.id,
      title: title,
      isDone: isDone,
      indentLevel: indentLevel,
      index: index,
      createdAt: createdAt,
    );
  }

  Future<void> update({
    required String userId,
    required String id,
    String? title,
    bool? isDone,
    int? indentLevel,
    int? index,
  }) async {
    await ref
        .read(userDocumentProvider(userId))
        .collection("todos")
        .doc(id)
        .update({
      if (title != null) 'title': title,
      if (isDone != null) 'isDone': isDone,
      if (indentLevel != null) 'indentLevel': indentLevel,
      if (index != null) 'index': index,
    });
  }

  Future<void> delete({required String userId, required String id}) async {
    await ref
        .read(userDocumentProvider(userId))
        .collection("todos")
        .doc(id)
        .delete();
  }

  /// 並び順を更新する
  Future<void> updateOrder(
      {required String userId, required List<Todo> todos}) async {
    final firestore = ref.read(firestoreProvider);
    final batch = firestore.batch();

    for (final todo in todos) {
      batch.update(
          ref
              .read(userDocumentProvider(userId))
              .collection("todos")
              .doc(todo.id),
          {
            'index': todo.index,
          });
    }
    await batch.commit();
  }
}
