// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Memo {
  String get deltaJson => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MemoCopyWith<Memo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoCopyWith<$Res> {
  factory $MemoCopyWith(Memo value, $Res Function(Memo) then) =
      _$MemoCopyWithImpl<$Res, Memo>;
  @useResult
  $Res call({String deltaJson});
}

/// @nodoc
class _$MemoCopyWithImpl<$Res, $Val extends Memo>
    implements $MemoCopyWith<$Res> {
  _$MemoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deltaJson = null,
  }) {
    return _then(_value.copyWith(
      deltaJson: null == deltaJson
          ? _value.deltaJson
          : deltaJson // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MemoImplCopyWith<$Res> implements $MemoCopyWith<$Res> {
  factory _$$MemoImplCopyWith(
          _$MemoImpl value, $Res Function(_$MemoImpl) then) =
      __$$MemoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String deltaJson});
}

/// @nodoc
class __$$MemoImplCopyWithImpl<$Res>
    extends _$MemoCopyWithImpl<$Res, _$MemoImpl>
    implements _$$MemoImplCopyWith<$Res> {
  __$$MemoImplCopyWithImpl(_$MemoImpl _value, $Res Function(_$MemoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deltaJson = null,
  }) {
    return _then(_$MemoImpl(
      deltaJson: null == deltaJson
          ? _value.deltaJson
          : deltaJson // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MemoImpl implements _Memo {
  const _$MemoImpl({required this.deltaJson});

  @override
  final String deltaJson;

  @override
  String toString() {
    return 'Memo(deltaJson: $deltaJson)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoImpl &&
            (identical(other.deltaJson, deltaJson) ||
                other.deltaJson == deltaJson));
  }

  @override
  int get hashCode => Object.hash(runtimeType, deltaJson);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoImplCopyWith<_$MemoImpl> get copyWith =>
      __$$MemoImplCopyWithImpl<_$MemoImpl>(this, _$identity);
}

abstract class _Memo implements Memo {
  const factory _Memo({required final String deltaJson}) = _$MemoImpl;

  @override
  String get deltaJson;
  @override
  @JsonKey(ignore: true)
  _$$MemoImplCopyWith<_$MemoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
