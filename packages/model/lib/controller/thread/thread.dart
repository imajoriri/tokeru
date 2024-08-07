import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:tokeru_model/model.dart';
import 'package:tokeru_model/repository/app_item/app_item_repository.dart';

part 'thread.g.dart';

@riverpod
class SelectedThread extends _$SelectedThread {
  @override
  AppItem? build() {
    return null;
  }

  void open(String appItemId) async {
    // TODO: streamにしてリアルタイムでデータを更新するようにしたい。
    final user = ref.read(userControllerProvider).requireValue;
    final repository = ref.watch(appItemRepositoryProvider(user.id));
    final item = await repository.fetchById(userId: user.id, id: appItemId);
    state = item;
  }
}
