import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_provider.g.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

@Riverpod(keepAlive: true)
DocumentReference userDocument(UserDocumentRef ref, String userId) {
  return ref.watch(firestoreProvider).collection('users').doc(userId);
}
