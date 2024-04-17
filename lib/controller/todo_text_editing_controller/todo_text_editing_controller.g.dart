// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_text_editing_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoTextEditingControllerHash() =>
    r'665f743b2ee05039d55c0e1182f80ee36b8920c6';

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

abstract class _$TodoTextEditingController
    extends BuildlessAutoDisposeNotifier<TextEditingController> {
  late final Todo todo;

  TextEditingController build(
    Todo todo,
  );
}

/// Todoリストの[Text]を管理するProvider
///
/// Copied from [TodoTextEditingController].
@ProviderFor(TodoTextEditingController)
const todoTextEditingControllerProvider = TodoTextEditingControllerFamily();

/// Todoリストの[Text]を管理するProvider
///
/// Copied from [TodoTextEditingController].
class TodoTextEditingControllerFamily extends Family<TextEditingController> {
  /// Todoリストの[Text]を管理するProvider
  ///
  /// Copied from [TodoTextEditingController].
  const TodoTextEditingControllerFamily();

  /// Todoリストの[Text]を管理するProvider
  ///
  /// Copied from [TodoTextEditingController].
  TodoTextEditingControllerProvider call(
    Todo todo,
  ) {
    return TodoTextEditingControllerProvider(
      todo,
    );
  }

  @override
  TodoTextEditingControllerProvider getProviderOverride(
    covariant TodoTextEditingControllerProvider provider,
  ) {
    return call(
      provider.todo,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'todoTextEditingControllerProvider';
}

/// Todoリストの[Text]を管理するProvider
///
/// Copied from [TodoTextEditingController].
class TodoTextEditingControllerProvider extends AutoDisposeNotifierProviderImpl<
    TodoTextEditingController, TextEditingController> {
  /// Todoリストの[Text]を管理するProvider
  ///
  /// Copied from [TodoTextEditingController].
  TodoTextEditingControllerProvider(
    Todo todo,
  ) : this._internal(
          () => TodoTextEditingController()..todo = todo,
          from: todoTextEditingControllerProvider,
          name: r'todoTextEditingControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$todoTextEditingControllerHash,
          dependencies: TodoTextEditingControllerFamily._dependencies,
          allTransitiveDependencies:
              TodoTextEditingControllerFamily._allTransitiveDependencies,
          todo: todo,
        );

  TodoTextEditingControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.todo,
  }) : super.internal();

  final Todo todo;

  @override
  TextEditingController runNotifierBuild(
    covariant TodoTextEditingController notifier,
  ) {
    return notifier.build(
      todo,
    );
  }

  @override
  Override overrideWith(TodoTextEditingController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TodoTextEditingControllerProvider._internal(
        () => create()..todo = todo,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        todo: todo,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TodoTextEditingController,
      TextEditingController> createElement() {
    return _TodoTextEditingControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoTextEditingControllerProvider && other.todo == todo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, todo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodoTextEditingControllerRef
    on AutoDisposeNotifierProviderRef<TextEditingController> {
  /// The parameter `todo` of this provider.
  Todo get todo;
}

class _TodoTextEditingControllerProviderElement
    extends AutoDisposeNotifierProviderElement<TodoTextEditingController,
        TextEditingController> with TodoTextEditingControllerRef {
  _TodoTextEditingControllerProviderElement(super.provider);

  @override
  Todo get todo => (origin as TodoTextEditingControllerProvider).todo;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
