import 'package:url_launcher/url_launcher.dart';

/// URLのコントローラー
enum UrlController {
  /// 開発者のXアカウント
  developerXAccount("https://twitter.com/imasirooo"),

  /// 機能リクエスト
  featureRequest(
    'https://github.com/tinp-lab/tokeru/issues/new?template=feature_request.md',
  ),

  /// バグ報告
  bugReport(
    'https://github.com/tinp-lab/tokeru/issues/new?template=bug_report.md',
  ),

  /// TokeruのGitHub Repository
  tokeruRepository('https://github.com/tinp-lab/tokeru'),
  ;

  const UrlController(this.url);

  /// URL
  final String url;

  /// ブラウザで開く
  Future<void> launch() async {
    await launchUrl(Uri.parse(url));
  }
}
