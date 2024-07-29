class User {
  /// ユーザーID
  ///
  /// Firebase Authentication のuidを使用しています。
  String id;

  /// 匿名ログインかどうか。
  bool isAnonymous;

  User({
    required this.id,
    required this.isAnonymous,
  });
}
