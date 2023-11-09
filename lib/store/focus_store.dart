import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'focus_store.g.dart';

enum FocusNodeType {
  main,
  chat,
  sidebarChat,
}

@riverpod
FocusNode focusNode(FocusNodeRef ref, FocusNodeType key) {
  return FocusNode();
}
