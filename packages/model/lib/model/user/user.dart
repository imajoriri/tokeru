class User {
  /// ユーザーID
  ///
  /// Firebase Authentication のuidを使用しています。
  String id;

  /// idToken
  String idToken;

  User({
    required this.id,
    required this.idToken,
  });
}
