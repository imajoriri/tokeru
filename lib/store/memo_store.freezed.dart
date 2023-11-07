// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memo_store.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MemoState {
  List<Memo> get memos => throw _privateConstructorUsedError;
  List<Memo> get bookmarks => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MemoStateCopyWith<MemoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoStateCopyWith<$Res> {
  factory $MemoStateCopyWith(MemoState value, $Res Function(MemoState) then) =
      _$MemoStateCopyWithImpl<$Res, MemoState>;
  @useResult
  $Res call({List<Memo> memos, List<Memo> bookmarks});
}

/// @nodoc
class _$MemoStateCopyWithImpl<$Res, $Val extends MemoState>
    implements $MemoStateCopyWith<$Res> {
  _$MemoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memos = null,
    Object? bookmarks = null,
  }) {
    return _then(_value.copyWith(
      memos: null == memos
          ? _value.memos
          : memos // ignore: cast_nullable_to_non_nullable
              as List<Memo>,
      bookmarks: null == bookmarks
          ? _value.bookmarks
          : bookmarks // ignore: cast_nullable_to_non_nullable
              as List<Memo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MemoStateImplCopyWith<$Res>
    implements $MemoStateCopyWith<$Res> {
  factory _$$MemoStateImplCopyWith(
          _$MemoStateImpl value, $Res Function(_$MemoStateImpl) then) =
      __$$MemoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Memo> memos, List<Memo> bookmarks});
}

/// @nodoc
class __$$MemoStateImplCopyWithImpl<$Res>
    extends _$MemoStateCopyWithImpl<$Res, _$MemoStateImpl>
    implements _$$MemoStateImplCopyWith<$Res> {
  __$$MemoStateImplCopyWithImpl(
      _$MemoStateImpl _value, $Res Function(_$MemoStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memos = null,
    Object? bookmarks = null,
  }) {
    return _then(_$MemoStateImpl(
      memos: null == memos
          ? _value._memos
          : memos // ignore: cast_nullable_to_non_nullable
              as List<Memo>,
      bookmarks: null == bookmarks
          ? _value._bookmarks
          : bookmarks // ignore: cast_nullable_to_non_nullable
              as List<Memo>,
    ));
  }
}

/// @nodoc

class _$MemoStateImpl implements _MemoState {
  const _$MemoStateImpl(
      {final List<Memo> memos = const [],
      final List<Memo> bookmarks = const []})
      : _memos = memos,
        _bookmarks = bookmarks;

  final List<Memo> _memos;
  @override
  @JsonKey()
  List<Memo> get memos {
    if (_memos is EqualUnmodifiableListView) return _memos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memos);
  }

  final List<Memo> _bookmarks;
  @override
  @JsonKey()
  List<Memo> get bookmarks {
    if (_bookmarks is EqualUnmodifiableListView) return _bookmarks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookmarks);
  }

  @override
  String toString() {
    return 'MemoState(memos: $memos, bookmarks: $bookmarks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoStateImpl &&
            const DeepCollectionEquality().equals(other._memos, _memos) &&
            const DeepCollectionEquality()
                .equals(other._bookmarks, _bookmarks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_memos),
      const DeepCollectionEquality().hash(_bookmarks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoStateImplCopyWith<_$MemoStateImpl> get copyWith =>
      __$$MemoStateImplCopyWithImpl<_$MemoStateImpl>(this, _$identity);
}

abstract class _MemoState implements MemoState {
  const factory _MemoState(
      {final List<Memo> memos, final List<Memo> bookmarks}) = _$MemoStateImpl;

  @override
  List<Memo> get memos;
  @override
  List<Memo> get bookmarks;
  @override
  @JsonKey(ignore: true)
  _$$MemoStateImplCopyWith<_$MemoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
