// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generative_sub_todo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$generativeSubTodoHash() => r'968e2911b212a8e04fa4ad4d5e4115287b139965';

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

abstract class _$GenerativeSubTodo
    extends BuildlessAutoDisposeAsyncNotifier<List<String>> {
  late final String parentTodoTitle;

  FutureOr<List<String>> build({
    required String parentTodoTitle,
  });
}

/// See also [GenerativeSubTodo].
@ProviderFor(GenerativeSubTodo)
const generativeSubTodoProvider = GenerativeSubTodoFamily();

/// See also [GenerativeSubTodo].
class GenerativeSubTodoFamily extends Family {
  /// See also [GenerativeSubTodo].
  const GenerativeSubTodoFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'generativeSubTodoProvider';

  /// See also [GenerativeSubTodo].
  GenerativeSubTodoProvider call({
    required String parentTodoTitle,
  }) {
    return GenerativeSubTodoProvider(
      parentTodoTitle: parentTodoTitle,
    );
  }

  @visibleForOverriding
  @override
  GenerativeSubTodoProvider getProviderOverride(
    covariant GenerativeSubTodoProvider provider,
  ) {
    return call(
      parentTodoTitle: provider.parentTodoTitle,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(GenerativeSubTodo Function() create) {
    return _$GenerativeSubTodoFamilyOverride(this, create);
  }
}

class _$GenerativeSubTodoFamilyOverride implements FamilyOverride {
  _$GenerativeSubTodoFamilyOverride(this.overriddenFamily, this.create);

  final GenerativeSubTodo Function() create;

  @override
  final GenerativeSubTodoFamily overriddenFamily;

  @override
  GenerativeSubTodoProvider getProviderOverride(
    covariant GenerativeSubTodoProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [GenerativeSubTodo].
class GenerativeSubTodoProvider extends AutoDisposeAsyncNotifierProviderImpl<
    GenerativeSubTodo, List<String>> {
  /// See also [GenerativeSubTodo].
  GenerativeSubTodoProvider({
    required String parentTodoTitle,
  }) : this._internal(
          () => GenerativeSubTodo()..parentTodoTitle = parentTodoTitle,
          from: generativeSubTodoProvider,
          name: r'generativeSubTodoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$generativeSubTodoHash,
          dependencies: GenerativeSubTodoFamily._dependencies,
          allTransitiveDependencies:
              GenerativeSubTodoFamily._allTransitiveDependencies,
          parentTodoTitle: parentTodoTitle,
        );

  GenerativeSubTodoProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parentTodoTitle,
  }) : super.internal();

  final String parentTodoTitle;

  @override
  FutureOr<List<String>> runNotifierBuild(
    covariant GenerativeSubTodo notifier,
  ) {
    return notifier.build(
      parentTodoTitle: parentTodoTitle,
    );
  }

  @override
  Override overrideWith(GenerativeSubTodo Function() create) {
    return ProviderOverride(
      origin: this,
      override: GenerativeSubTodoProvider._internal(
        () => create()..parentTodoTitle = parentTodoTitle,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parentTodoTitle: parentTodoTitle,
      ),
    );
  }

  @override
  ({
    String parentTodoTitle,
  }) get argument {
    return (parentTodoTitle: parentTodoTitle,);
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<GenerativeSubTodo, List<String>>
      createElement() {
    return _GenerativeSubTodoProviderElement(this);
  }

  GenerativeSubTodoProvider _copyWith(
    GenerativeSubTodo Function() create,
  ) {
    return GenerativeSubTodoProvider._internal(
      () => create()..parentTodoTitle = parentTodoTitle,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      parentTodoTitle: parentTodoTitle,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GenerativeSubTodoProvider &&
        other.parentTodoTitle == parentTodoTitle;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parentTodoTitle.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GenerativeSubTodoRef
    on AutoDisposeAsyncNotifierProviderRef<List<String>> {
  /// The parameter `parentTodoTitle` of this provider.
  String get parentTodoTitle;
}

class _GenerativeSubTodoProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GenerativeSubTodo,
        List<String>> with GenerativeSubTodoRef {
  _GenerativeSubTodoProviderElement(super.provider);

  @override
  String get parentTodoTitle =>
      (origin as GenerativeSubTodoProvider).parentTodoTitle;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
