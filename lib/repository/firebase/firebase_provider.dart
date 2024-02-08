import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_provider.g.dart';

final firestoreProvider =
    Provider.autoDispose((ref) => FirebaseFirestore.instance);

@riverpod
DocumentReference userDocument(UserDocumentRef ref, String userId) {
  return ref.read(firestoreProvider).collection('users').doc(userId);
}
