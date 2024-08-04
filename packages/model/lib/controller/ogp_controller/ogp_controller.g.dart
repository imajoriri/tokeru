// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ogp_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ogpControllerHash() => r'da6fbaee30bc48ef42ccf6ebc579bd88f81f8048';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$OgpController extends BuildlessAsyncNotifier<Ogp> {
  late final String url;

  FutureOr<Ogp> build({
    required String url,
  });
}

/// OGP情報を取得するコントローラー。
///
/// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
///
/// Copied from [OgpController].
@ProviderFor(OgpController)
const ogpControllerProvider = OgpControllerFamily();

/// OGP情報を取得するコントローラー。
///
/// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
///
/// Copied from [OgpController].
class OgpControllerFamily extends Family {
  /// OGP情報を取得するコントローラー。
  ///
  /// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
  ///
  /// Copied from [OgpController].
  const OgpControllerFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ogpControllerProvider';

  /// OGP情報を取得するコントローラー。
  ///
  /// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
  ///
  /// Copied from [OgpController].
  OgpControllerProvider call({
    required String url,
  }) {
    return OgpControllerProvider(
      url: url,
    );
  }

  @visibleForOverriding
  @override
  OgpControllerProvider getProviderOverride(
    covariant OgpControllerProvider provider,
  ) {
    return call(
      url: provider.url,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(OgpController Function() create) {
    return _$OgpControllerFamilyOverride(this, create);
  }
}

class _$OgpControllerFamilyOverride implements FamilyOverride {
  _$OgpControllerFamilyOverride(this.overriddenFamily, this.create);

  final OgpController Function() create;

  @override
  final OgpControllerFamily overriddenFamily;

  @override
  OgpControllerProvider getProviderOverride(
    covariant OgpControllerProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// OGP情報を取得するコントローラー。
///
/// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
///
/// Copied from [OgpController].
class OgpControllerProvider
    extends AsyncNotifierProviderImpl<OgpController, Ogp> {
  /// OGP情報を取得するコントローラー。
  ///
  /// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
  ///
  /// Copied from [OgpController].
  OgpControllerProvider({
    required String url,
  }) : this._internal(
          () => OgpController()..url = url,
          from: ogpControllerProvider,
          name: r'ogpControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ogpControllerHash,
          dependencies: OgpControllerFamily._dependencies,
          allTransitiveDependencies:
              OgpControllerFamily._allTransitiveDependencies,
          url: url,
        );

  OgpControllerProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
  }) : super.internal();

  final String url;

  @override
  FutureOr<Ogp> runNotifierBuild(
    covariant OgpController notifier,
  ) {
    return notifier.build(
      url: url,
    );
  }

  @override
  Override overrideWith(OgpController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OgpControllerProvider._internal(
        () => create()..url = url,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
      ),
    );
  }

  @override
  ({
    String url,
  }) get argument {
    return (url: url,);
  }

  @override
  AsyncNotifierProviderElement<OgpController, Ogp> createElement() {
    return _OgpControllerProviderElement(this);
  }

  OgpControllerProvider _copyWith(
    OgpController Function() create,
  ) {
    return OgpControllerProvider._internal(
      () => create()..url = url,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      url: url,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is OgpControllerProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OgpControllerRef on AsyncNotifierProviderRef<Ogp> {
  /// The parameter `url` of this provider.
  String get url;
}

class _OgpControllerProviderElement
    extends AsyncNotifierProviderElement<OgpController, Ogp>
    with OgpControllerRef {
  _OgpControllerProviderElement(super.provider);

  @override
  String get url => (origin as OgpControllerProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
