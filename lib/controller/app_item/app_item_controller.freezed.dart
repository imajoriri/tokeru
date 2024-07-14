// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_item_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppItemControllerState {
  List<AppItem> get chatItems => throw _privateConstructorUsedError;
  List<AppTodoItem> get todos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppItemControllerStateCopyWith<AppItemControllerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppItemControllerStateCopyWith<$Res> {
  factory $AppItemControllerStateCopyWith(AppItemControllerState value,
          $Res Function(AppItemControllerState) then) =
      _$AppItemControllerStateCopyWithImpl<$Res, AppItemControllerState>;
  @useResult
  $Res call({List<AppItem> chatItems, List<AppTodoItem> todos});
}

/// @nodoc
class _$AppItemControllerStateCopyWithImpl<$Res,
        $Val extends AppItemControllerState>
    implements $AppItemControllerStateCopyWith<$Res> {
  _$AppItemControllerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatItems = null,
    Object? todos = null,
  }) {
    return _then(_value.copyWith(
      chatItems: null == chatItems
          ? _value.chatItems
          : chatItems // ignore: cast_nullable_to_non_nullable
              as List<AppItem>,
      todos: null == todos
          ? _value.todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<AppTodoItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppItemControllerStateImplCopyWith<$Res>
    implements $AppItemControllerStateCopyWith<$Res> {
  factory _$$AppItemControllerStateImplCopyWith(
          _$AppItemControllerStateImpl value,
          $Res Function(_$AppItemControllerStateImpl) then) =
      __$$AppItemControllerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AppItem> chatItems, List<AppTodoItem> todos});
}

/// @nodoc
class __$$AppItemControllerStateImplCopyWithImpl<$Res>
    extends _$AppItemControllerStateCopyWithImpl<$Res,
        _$AppItemControllerStateImpl>
    implements _$$AppItemControllerStateImplCopyWith<$Res> {
  __$$AppItemControllerStateImplCopyWithImpl(
      _$AppItemControllerStateImpl _value,
      $Res Function(_$AppItemControllerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatItems = null,
    Object? todos = null,
  }) {
    return _then(_$AppItemControllerStateImpl(
      chatItems: null == chatItems
          ? _value._chatItems
          : chatItems // ignore: cast_nullable_to_non_nullable
              as List<AppItem>,
      todos: null == todos
          ? _value._todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<AppTodoItem>,
    ));
  }
}

/// @nodoc

class _$AppItemControllerStateImpl implements _AppItemControllerState {
  const _$AppItemControllerStateImpl(
      {required final List<AppItem> chatItems,
      required final List<AppTodoItem> todos})
      : _chatItems = chatItems,
        _todos = todos;

  final List<AppItem> _chatItems;
  @override
  List<AppItem> get chatItems {
    if (_chatItems is EqualUnmodifiableListView) return _chatItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatItems);
  }

  final List<AppTodoItem> _todos;
  @override
  List<AppTodoItem> get todos {
    if (_todos is EqualUnmodifiableListView) return _todos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todos);
  }

  @override
  String toString() {
    return 'AppItemControllerState(chatItems: $chatItems, todos: $todos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppItemControllerStateImpl &&
            const DeepCollectionEquality()
                .equals(other._chatItems, _chatItems) &&
            const DeepCollectionEquality().equals(other._todos, _todos));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_chatItems),
      const DeepCollectionEquality().hash(_todos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppItemControllerStateImplCopyWith<_$AppItemControllerStateImpl>
      get copyWith => __$$AppItemControllerStateImplCopyWithImpl<
          _$AppItemControllerStateImpl>(this, _$identity);
}

abstract class _AppItemControllerState implements AppItemControllerState {
  const factory _AppItemControllerState(
      {required final List<AppItem> chatItems,
      required final List<AppTodoItem> todos}) = _$AppItemControllerStateImpl;

  @override
  List<AppItem> get chatItems;
  @override
  List<AppTodoItem> get todos;
  @override
  @JsonKey(ignore: true)
  _$$AppItemControllerStateImplCopyWith<_$AppItemControllerStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
