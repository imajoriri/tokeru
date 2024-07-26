import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_model/controller/refresh/refresh_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reload_action.g.dart';

/// データを更新する[Intent]
class ReloadIntent extends Intent {
  const ReloadIntent();
}

@riverpod
ReloadAction reloadAction(ReloadActionRef ref) => ReloadAction(ref);

class ReloadAction extends Action<ReloadIntent> {
  ReloadAction(this.ref);
  final Ref ref;

  @override
  Object? invoke(covariant ReloadIntent intent) async {
    ref.invalidate(refreshControllerProvider);
    return null;
  }
}
