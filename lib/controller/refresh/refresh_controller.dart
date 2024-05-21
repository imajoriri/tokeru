import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refresh_controller.g.dart';

/// データを更新するためのコントローラー。
///
/// このコントローラーをref.watchすることで、データの更新を行う。
@Riverpod(keepAlive: true)
void refreshController(RefreshControllerRef ref) {}
