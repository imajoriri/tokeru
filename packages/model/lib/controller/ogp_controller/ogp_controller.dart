import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:tokeru_model/controller/refresh/refresh_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tokeru_model/model.dart';

part 'ogp_controller.g.dart';

/// OGP情報を取得するコントローラー。
///
/// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
@Riverpod(keepAlive: true)
class OgpController extends _$OgpController {
  @override
  FutureOr<Ogp> build({required String url}) async {
    ref.watch(refreshControllerProvider);
    final document = await MetadataFetch.extract(url);
    return Ogp(
      url: url,
      title: document?.title ?? '',
      description: document?.description ?? '',
      imageUrl: document?.image,
    );
  }
}
