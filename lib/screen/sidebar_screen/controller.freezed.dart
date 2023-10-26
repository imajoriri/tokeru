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
mixin _$SidebarScreenState {
  bool get isShow => throw _privateConstructorUsedError;
  Memo? get memo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SidebarScreenStateCopyWith<SidebarScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidebarScreenStateCopyWith<$Res> {
  factory $SidebarScreenStateCopyWith(
          SidebarScreenState value, $Res Function(SidebarScreenState) then) =
      _$SidebarScreenStateCopyWithImpl<$Res, SidebarScreenState>;
  @useResult
  $Res call({bool isShow, Memo? memo});

  $MemoCopyWith<$Res>? get memo;
}

/// @nodoc
class _$SidebarScreenStateCopyWithImpl<$Res, $Val extends SidebarScreenState>
    implements $SidebarScreenStateCopyWith<$Res> {
  _$SidebarScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isShow = null,
    Object? memo = freezed,
  }) {
    return _then(_value.copyWith(
      isShow: null == isShow
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as Memo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MemoCopyWith<$Res>? get memo {
    if (_value.memo == null) {
      return null;
    }

    return $MemoCopyWith<$Res>(_value.memo!, (value) {
      return _then(_value.copyWith(memo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SidebarScreenStateImplCopyWith<$Res>
    implements $SidebarScreenStateCopyWith<$Res> {
  factory _$$SidebarScreenStateImplCopyWith(_$SidebarScreenStateImpl value,
          $Res Function(_$SidebarScreenStateImpl) then) =
      __$$SidebarScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isShow, Memo? memo});

  @override
  $MemoCopyWith<$Res>? get memo;
}

/// @nodoc
class __$$SidebarScreenStateImplCopyWithImpl<$Res>
    extends _$SidebarScreenStateCopyWithImpl<$Res, _$SidebarScreenStateImpl>
    implements _$$SidebarScreenStateImplCopyWith<$Res> {
  __$$SidebarScreenStateImplCopyWithImpl(_$SidebarScreenStateImpl _value,
      $Res Function(_$SidebarScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isShow = null,
    Object? memo = freezed,
  }) {
    return _then(_$SidebarScreenStateImpl(
      isShow: null == isShow
          ? _value.isShow
          : isShow // ignore: cast_nullable_to_non_nullable
              as bool,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as Memo?,
    ));
  }
}

/// @nodoc

class _$SidebarScreenStateImpl implements _SidebarScreenState {
  _$SidebarScreenStateImpl({this.isShow = false, this.memo});

  @override
  @JsonKey()
  final bool isShow;
  @override
  final Memo? memo;

  @override
  String toString() {
    return 'SidebarScreenState(isShow: $isShow, memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SidebarScreenStateImpl &&
            (identical(other.isShow, isShow) || other.isShow == isShow) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isShow, memo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SidebarScreenStateImplCopyWith<_$SidebarScreenStateImpl> get copyWith =>
      __$$SidebarScreenStateImplCopyWithImpl<_$SidebarScreenStateImpl>(
          this, _$identity);
}

abstract class _SidebarScreenState implements SidebarScreenState {
  factory _SidebarScreenState({final bool isShow, final Memo? memo}) =
      _$SidebarScreenStateImpl;

  @override
  bool get isShow;
  @override
  Memo? get memo;
  @override
  @JsonKey(ignore: true)
  _$$SidebarScreenStateImplCopyWith<_$SidebarScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
