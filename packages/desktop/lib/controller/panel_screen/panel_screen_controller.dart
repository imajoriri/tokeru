import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/model.dart';
import 'package:tokeru_model/repository/app_item/app_item_repository.dart';
import 'package:uuid/uuid.dart';

part 'panel_screen_controller.g.dart';

/// [PanelScreen]のコントローラー。
@riverpod
class PanelScreenController extends _$PanelScreenController {
  @override
  void build() {
    return;
  }

  /// [AppChatItem]を送信する。
  Future<void> send({required String message}) async {
    final chat = AppItem.chat(
      id: const Uuid().v4(),
      message: message,
      createdAt: DateTime.now(),
    );
    final user = await ref.read(userControllerProvider.future);
    final repository = ref.read(appItemRepositoryProvider(user.id));
    try {
      await repository.add(chat);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
