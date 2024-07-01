/// OGPの情報を保持するクラス。
class Ogp {
  final String title;
  final String description;
  final String imageUrl;

  Ogp({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory Ogp.fromJson(Map<String, dynamic> json) {
    return Ogp(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
