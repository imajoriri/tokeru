// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hot_key_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HotKeyState {
  LogicalKeyboardKey get key => throw _privateConstructorUsedError;
  List<LogicalKeyboardKey> get modifiers => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HotKeyStateCopyWith<HotKeyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HotKeyStateCopyWith<$Res> {
  factory $HotKeyStateCopyWith(
          HotKeyState value, $Res Function(HotKeyState) then) =
      _$HotKeyStateCopyWithImpl<$Res, HotKeyState>;
  @useResult
  $Res call({LogicalKeyboardKey key, List<LogicalKeyboardKey> modifiers});
}

/// @nodoc
class _$HotKeyStateCopyWithImpl<$Res, $Val extends HotKeyState>
    implements $HotKeyStateCopyWith<$Res> {
  _$HotKeyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? modifiers = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey,
      modifiers: null == modifiers
          ? _value.modifiers
          : modifiers // ignore: cast_nullable_to_non_nullable
              as List<LogicalKeyboardKey>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HotKeyStateImplCopyWith<$Res>
    implements $HotKeyStateCopyWith<$Res> {
  factory _$$HotKeyStateImplCopyWith(
          _$HotKeyStateImpl value, $Res Function(_$HotKeyStateImpl) then) =
      __$$HotKeyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LogicalKeyboardKey key, List<LogicalKeyboardKey> modifiers});
}

/// @nodoc
class __$$HotKeyStateImplCopyWithImpl<$Res>
    extends _$HotKeyStateCopyWithImpl<$Res, _$HotKeyStateImpl>
    implements _$$HotKeyStateImplCopyWith<$Res> {
  __$$HotKeyStateImplCopyWithImpl(
      _$HotKeyStateImpl _value, $Res Function(_$HotKeyStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? modifiers = null,
  }) {
    return _then(_$HotKeyStateImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as LogicalKeyboardKey,
      modifiers: null == modifiers
          ? _value._modifiers
          : modifiers // ignore: cast_nullable_to_non_nullable
              as List<LogicalKeyboardKey>,
    ));
  }
}

/// @nodoc

class _$HotKeyStateImpl implements _HotKeyState {
  const _$HotKeyStateImpl(
      {required this.key, required final List<LogicalKeyboardKey> modifiers})
      : _modifiers = modifiers;

  @override
  final LogicalKeyboardKey key;
  final List<LogicalKeyboardKey> _modifiers;
  @override
  List<LogicalKeyboardKey> get modifiers {
    if (_modifiers is EqualUnmodifiableListView) return _modifiers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modifiers);
  }

  @override
  String toString() {
    return 'HotKeyState(key: $key, modifiers: $modifiers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotKeyStateImpl &&
            (identical(other.key, key) || other.key == key) &&
            const DeepCollectionEquality()
                .equals(other._modifiers, _modifiers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, key, const DeepCollectionEquality().hash(_modifiers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HotKeyStateImplCopyWith<_$HotKeyStateImpl> get copyWith =>
      __$$HotKeyStateImplCopyWithImpl<_$HotKeyStateImpl>(this, _$identity);
}

abstract class _HotKeyState implements HotKeyState {
  const factory _HotKeyState(
      {required final LogicalKeyboardKey key,
      required final List<LogicalKeyboardKey> modifiers}) = _$HotKeyStateImpl;

  @override
  LogicalKeyboardKey get key;
  @override
  List<LogicalKeyboardKey> get modifiers;
  @override
  @JsonKey(ignore: true)
  _$$HotKeyStateImplCopyWith<_$HotKeyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
