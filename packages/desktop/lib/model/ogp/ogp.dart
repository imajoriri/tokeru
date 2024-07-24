/// OGPの情報を保持するクラス。
class Ogp {
  /// URL。
  final String url;

  /// タイトル。
  final String title;

  /// 説明。
  final String description;

  /// 画像URL。
  final String imageUrl;

  const Ogp({
    required this.url,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
