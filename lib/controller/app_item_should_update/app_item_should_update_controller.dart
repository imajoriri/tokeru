import 'package:quick_flutter/controller/today_app_item/today_app_item_controller.dart';
import 'package:quick_flutter/utils/method_channel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_item_should_update_controller.g.dart';

/// [TodayAppItemController]の更新を管理するコントローラー。
///
/// 最終更新日の日をを返す。
/// 以下のタイミングで自信がinvalidateされる。
///
/// - ウィンドウが非アクティブの状態で[AppItem]が更新された場合。
@Riverpod(keepAlive: true)
class AppItemShouldUpdateController extends _$AppItemShouldUpdateController {
  @override
  DateTime build() {
    mainMethodChannel.addListnerActive((type) async {
      // TODO: Firebaseをwatchして、更新があった場合に更新する。
      if (type == MainOsHandlerType.windowActive) {
        ref.invalidateSelf();
      }
    });
    return DateTime.now();
  }
}
