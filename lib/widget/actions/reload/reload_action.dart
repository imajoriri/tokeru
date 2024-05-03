import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/google_sign_in/google_sign_in_controller.dart';
import 'package:quick_flutter/controller/today_calendar_event/today_calendar_event_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
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
    ref.invalidate(googleSignInControllerProvider);
    ref.invalidate(todayCalendarEventControllerProvider);
    ref.invalidate(todoControllerProvider);
    return null;
  }
}
