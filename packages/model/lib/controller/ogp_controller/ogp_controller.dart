import 'package:dio/dio.dart';
import 'package:tokeru_model/controller/refresh/refresh_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';
import 'package:tokeru_model/model.dart';

part 'ogp_controller.g.dart';

// 他の箇所でDioを使わないのでここに書いているが、
// 他の箇所でも使うようになったら共通化する。
final _dio = Dio();

/// OGP情報を取得するコントローラー。
///
/// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
@Riverpod(keepAlive: true)
class OgpController extends _$OgpController {
  @override
  FutureOr<Ogp> build({required String url}) async {
    ref.watch(refreshControllerProvider);

    final response = await _dio.get(
      url,
      options: Options(
        headers: {
          // X(Twitter)でこのヘッダーがないとOGPが取得できない。
          "User-Agent": "bot",
        },
      ),
    );

    // レスポンスが200以外の場合は例外を投げる
    if (response.statusCode != 200) {
      throw Exception('Failed to load URL');
    }

    final document = html_parser.parse(response.data);

    // OGPメタタグを抽出
    String title = '';
    String description = '';
    String? imageUrl;

    // metaタグから取得する。
    document.getElementsByTagName('meta').forEach((Element element) {
      // title
      if (element.attributes['property'] == 'og:title') {
        title = element.attributes['content'] ?? '';
      }
      if (element.attributes['property'] == 'title') {
        title = element.attributes['content'] ?? '';
      }

      // description
      if (element.attributes['property'] == 'og:description') {
        description = element.attributes['content'] ?? '';
      }
      if (element.attributes['name'] == 'description') {
        description = element.attributes['content'] ?? '';
      }

      // image
      if (element.attributes['property'] == 'og:image') {
        imageUrl = element.attributes['content'];
      }
    });

    // metaタグからの取得ができなかった場合は、titleタグから取得する。
    if (title.isEmpty) {
      final titleTag = document.getElementsByTagName('title');
      if (titleTag.isNotEmpty) {
        title = titleTag.first.text;
      }
    }

    // metaタグからの取得ができなかった場合は、descriptionタグから取得する。
    if (description.isEmpty) {
      final descriptionTag = document.getElementsByTagName('description');
      if (descriptionTag.isNotEmpty) {
        description = descriptionTag.first.text;
      }
    }

    return Ogp(
      url: url,
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }
}
