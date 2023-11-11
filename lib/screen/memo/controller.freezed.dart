// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatScreenState {
  List<String> get drafts => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatScreenStateCopyWith<ChatScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatScreenStateCopyWith<$Res> {
  factory $ChatScreenStateCopyWith(
          ChatScreenState value, $Res Function(ChatScreenState) then) =
      _$ChatScreenStateCopyWithImpl<$Res, ChatScreenState>;
  @useResult
  $Res call({List<String> drafts});
}

/// @nodoc
class _$ChatScreenStateCopyWithImpl<$Res, $Val extends ChatScreenState>
    implements $ChatScreenStateCopyWith<$Res> {
  _$ChatScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? drafts = null,
  }) {
    return _then(_value.copyWith(
      drafts: null == drafts
          ? _value.drafts
          : drafts // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatScreenStateImplCopyWith<$Res>
    implements $ChatScreenStateCopyWith<$Res> {
  factory _$$ChatScreenStateImplCopyWith(_$ChatScreenStateImpl value,
          $Res Function(_$ChatScreenStateImpl) then) =
      __$$ChatScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> drafts});
}

/// @nodoc
class __$$ChatScreenStateImplCopyWithImpl<$Res>
    extends _$ChatScreenStateCopyWithImpl<$Res, _$ChatScreenStateImpl>
    implements _$$ChatScreenStateImplCopyWith<$Res> {
  __$$ChatScreenStateImplCopyWithImpl(
      _$ChatScreenStateImpl _value, $Res Function(_$ChatScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? drafts = null,
  }) {
    return _then(_$ChatScreenStateImpl(
      drafts: null == drafts
          ? _value._drafts
          : drafts // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$ChatScreenStateImpl implements _ChatScreenState {
  _$ChatScreenStateImpl({final List<String> drafts = const []})
      : _drafts = drafts;

  final List<String> _drafts;
  @override
  @JsonKey()
  List<String> get drafts {
    if (_drafts is EqualUnmodifiableListView) return _drafts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_drafts);
  }

  @override
  String toString() {
    return 'ChatScreenState(drafts: $drafts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatScreenStateImpl &&
            const DeepCollectionEquality().equals(other._drafts, _drafts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_drafts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatScreenStateImplCopyWith<_$ChatScreenStateImpl> get copyWith =>
      __$$ChatScreenStateImplCopyWithImpl<_$ChatScreenStateImpl>(
          this, _$identity);
}

abstract class _ChatScreenState implements ChatScreenState {
  factory _ChatScreenState({final List<String> drafts}) = _$ChatScreenStateImpl;

  @override
  List<String> get drafts;
  @override
  @JsonKey(ignore: true)
  _$$ChatScreenStateImplCopyWith<_$ChatScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
