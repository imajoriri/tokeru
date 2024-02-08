import 'package:quick_flutter/model/user/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_controller.g.dart';

@Riverpod(keepAlive: true)
Future<User> userController(UserControllerRef ref) async {
  return User(id: 'user_id');
}
