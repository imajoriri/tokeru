import 'package:quick_flutter/systems/flavor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookmark_controller.g.dart';

@Riverpod(keepAlive: true)
class BookmarkController extends _$BookmarkController {
  @override
  bool build() {
    const flavorEnv = String.fromEnvironment('flavor');
    return flavorEnv == Flavor.prod.name ? false : true;
  }

  void toggle() {
    state = !state;
  }
}
