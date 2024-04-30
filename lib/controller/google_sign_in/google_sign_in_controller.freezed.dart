// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'google_sign_in_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GoogleSignInState {
  bool get isSignIn => throw _privateConstructorUsedError;
  AuthClient? get client => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GoogleSignInStateCopyWith<GoogleSignInState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoogleSignInStateCopyWith<$Res> {
  factory $GoogleSignInStateCopyWith(
          GoogleSignInState value, $Res Function(GoogleSignInState) then) =
      _$GoogleSignInStateCopyWithImpl<$Res, GoogleSignInState>;
  @useResult
  $Res call({bool isSignIn, AuthClient? client});
}

/// @nodoc
class _$GoogleSignInStateCopyWithImpl<$Res, $Val extends GoogleSignInState>
    implements $GoogleSignInStateCopyWith<$Res> {
  _$GoogleSignInStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSignIn = null,
    Object? client = freezed,
  }) {
    return _then(_value.copyWith(
      isSignIn: null == isSignIn
          ? _value.isSignIn
          : isSignIn // ignore: cast_nullable_to_non_nullable
              as bool,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as AuthClient?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoogleSignInStateImplCopyWith<$Res>
    implements $GoogleSignInStateCopyWith<$Res> {
  factory _$$GoogleSignInStateImplCopyWith(_$GoogleSignInStateImpl value,
          $Res Function(_$GoogleSignInStateImpl) then) =
      __$$GoogleSignInStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isSignIn, AuthClient? client});
}

/// @nodoc
class __$$GoogleSignInStateImplCopyWithImpl<$Res>
    extends _$GoogleSignInStateCopyWithImpl<$Res, _$GoogleSignInStateImpl>
    implements _$$GoogleSignInStateImplCopyWith<$Res> {
  __$$GoogleSignInStateImplCopyWithImpl(_$GoogleSignInStateImpl _value,
      $Res Function(_$GoogleSignInStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSignIn = null,
    Object? client = freezed,
  }) {
    return _then(_$GoogleSignInStateImpl(
      isSignIn: null == isSignIn
          ? _value.isSignIn
          : isSignIn // ignore: cast_nullable_to_non_nullable
              as bool,
      client: freezed == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as AuthClient?,
    ));
  }
}

/// @nodoc

class _$GoogleSignInStateImpl implements _GoogleSignInState {
  const _$GoogleSignInStateImpl({required this.isSignIn, this.client});

  @override
  final bool isSignIn;
  @override
  final AuthClient? client;

  @override
  String toString() {
    return 'GoogleSignInState(isSignIn: $isSignIn, client: $client)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoogleSignInStateImpl &&
            (identical(other.isSignIn, isSignIn) ||
                other.isSignIn == isSignIn) &&
            (identical(other.client, client) || other.client == client));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isSignIn, client);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoogleSignInStateImplCopyWith<_$GoogleSignInStateImpl> get copyWith =>
      __$$GoogleSignInStateImplCopyWithImpl<_$GoogleSignInStateImpl>(
          this, _$identity);
}

abstract class _GoogleSignInState implements GoogleSignInState {
  const factory _GoogleSignInState(
      {required final bool isSignIn,
      final AuthClient? client}) = _$GoogleSignInStateImpl;

  @override
  bool get isSignIn;
  @override
  AuthClient? get client;
  @override
  @JsonKey(ignore: true)
  _$$GoogleSignInStateImplCopyWith<_$GoogleSignInStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
