class User {
  /// ユーザーID
  ///
  /// Firebase Authentication のuidを使用しています。
  String id;

  /// idToken
  String idToken;

  /// 匿名ログインかどうか。
  bool isAnonymous;

  User({
    required this.id,
    required this.idToken,
    required this.isAnonymous,
  });
}
