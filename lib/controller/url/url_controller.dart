import 'package:url_launcher/url_launcher.dart';

/// URLのコントローラー
enum UrlController {
  /// 開発者のXアカウント
  developerXAccount("https://twitter.com/imasirooo"),

  /// フィードバックURL
  feedback(''),

  /// TokeruのGitHub Repository
  tokeruRepository(''),
  ;

  const UrlController(this.url);

  /// URL
  final String url;

  /// ブラウザで開く
  Future<void> launch() async {
    await launchUrl(Uri.parse(url));
  }
}
