import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/todo/todo.dart';
import 'package:quick_flutter/systems/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_repository.g.dart';

@riverpod
TodoRepository todoRepository(TodoRepositoryRef ref) =>
    TodoRepository(ref: ref);

class TodoRepository {
  TodoRepository({required this.ref});
  final Ref ref;

  Future<List<Todo>> fetchTodos() async {
    final firestore = ref.read(firestoreProvider);
    final response = await firestore
        .collection("todos")
        // .orderBy('createdAt', descending: true)
        .get();
    return (response.docs.map((doc) {
      return Todo(
        id: doc.id,
        title: doc.data()['title'] ?? '',
        isDone: doc.data()['isDone'] ?? false,
        indentLevel: doc.data()['indentLevel'] ?? 0,
        createdAt: doc.data()['createdAt'].toDate() ?? DateTime.now(),
      );
    }).toList());
  }

  /// Todoを追加し、idを返す
  Future<Todo> add({
    String title = '',
    bool isDone = false,
    int indentLevel = 0,
  }) async {
    final firestore = ref.read(firestoreProvider);
    final createdAt = DateTime.now();
    final res = await firestore.collection("todos").add({
      'title': title,
      'isDone': isDone,
      'indentLevel': indentLevel,
      'createdAt': createdAt,
    });
    return Todo(
      id: res.id,
      title: title,
      isDone: isDone,
      indentLevel: indentLevel,
      createdAt: createdAt,
    );
  }

  Future<void> update({
    required String id,
    String? title,
    bool? isDone,
    int? indentLevel,
  }) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.collection("todos").doc(id).update({
      if (title != null) 'title': title,
      if (isDone != null) 'isDone': isDone,
      if (indentLevel != null) 'indentLevel': indentLevel,
    });
  }

  Future<void> delete(String id) async {
    final firestore = ref.read(firestoreProvider);
    await firestore.collection("todos").doc(id).delete();
  }
}
