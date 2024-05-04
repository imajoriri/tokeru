// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoItem _$TodoItemFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'todo':
      return Todo.fromJson(json);
    case 'divider':
      return TodoDivider.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'TodoItem', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$TodoItem {
  String get id => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String title,
            bool isDone,
            int indentLevel,
            int index,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, bool isDone, int indentLevel,
            int index, @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, bool isDone, int indentLevel,
            int index, @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Todo value) todo,
    required TResult Function(TodoDivider value) divider,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Todo value)? todo,
    TResult? Function(TodoDivider value)? divider,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Todo value)? todo,
    TResult Function(TodoDivider value)? divider,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoItemCopyWith<TodoItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoItemCopyWith<$Res> {
  factory $TodoItemCopyWith(TodoItem value, $Res Function(TodoItem) then) =
      _$TodoItemCopyWithImpl<$Res, TodoItem>;
  @useResult
  $Res call({String id, int index, @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class _$TodoItemCopyWithImpl<$Res, $Val extends TodoItem>
    implements $TodoItemCopyWith<$Res> {
  _$TodoItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? index = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoImplCopyWith<$Res> implements $TodoItemCopyWith<$Res> {
  factory _$$TodoImplCopyWith(
          _$TodoImpl value, $Res Function(_$TodoImpl) then) =
      __$$TodoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      bool isDone,
      int indentLevel,
      int index,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$TodoImplCopyWithImpl<$Res>
    extends _$TodoItemCopyWithImpl<$Res, _$TodoImpl>
    implements _$$TodoImplCopyWith<$Res> {
  __$$TodoImplCopyWithImpl(_$TodoImpl _value, $Res Function(_$TodoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? isDone = null,
    Object? indentLevel = null,
    Object? index = null,
    Object? createdAt = null,
  }) {
    return _then(_$TodoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      indentLevel: null == indentLevel
          ? _value.indentLevel
          : indentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoImpl implements Todo {
  const _$TodoImpl(
      {required this.id,
      required this.title,
      required this.isDone,
      required this.indentLevel,
      required this.index,
      @TimestampConverter() required this.createdAt,
      final String? $type})
      : $type = $type ?? 'todo';

  factory _$TodoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final bool isDone;
  @override
  final int indentLevel;
  @override
  final int index;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'TodoItem.todo(id: $id, title: $title, isDone: $isDone, indentLevel: $indentLevel, index: $index, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isDone, isDone) || other.isDone == isDone) &&
            (identical(other.indentLevel, indentLevel) ||
                other.indentLevel == indentLevel) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, isDone, indentLevel, index, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoImplCopyWith<_$TodoImpl> get copyWith =>
      __$$TodoImplCopyWithImpl<_$TodoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String title,
            bool isDone,
            int indentLevel,
            int index,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) {
    return todo(id, title, isDone, indentLevel, index, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, bool isDone, int indentLevel,
            int index, @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) {
    return todo?.call(id, title, isDone, indentLevel, index, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, bool isDone, int indentLevel,
            int index, @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
    required TResult orElse(),
  }) {
    if (todo != null) {
      return todo(id, title, isDone, indentLevel, index, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Todo value) todo,
    required TResult Function(TodoDivider value) divider,
  }) {
    return todo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Todo value)? todo,
    TResult? Function(TodoDivider value)? divider,
  }) {
    return todo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Todo value)? todo,
    TResult Function(TodoDivider value)? divider,
    required TResult orElse(),
  }) {
    if (todo != null) {
      return todo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoImplToJson(
      this,
    );
  }
}

abstract class Todo implements TodoItem {
  const factory Todo(
      {required final String id,
      required final String title,
      required final bool isDone,
      required final int indentLevel,
      required final int index,
      @TimestampConverter() required final DateTime createdAt}) = _$TodoImpl;

  factory Todo.fromJson(Map<String, dynamic> json) = _$TodoImpl.fromJson;

  @override
  String get id;
  String get title;
  bool get isDone;
  int get indentLevel;
  @override
  int get index;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$TodoImplCopyWith<_$TodoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TodoDividerImplCopyWith<$Res>
    implements $TodoItemCopyWith<$Res> {
  factory _$$TodoDividerImplCopyWith(
          _$TodoDividerImpl value, $Res Function(_$TodoDividerImpl) then) =
      __$$TodoDividerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, int index, @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$TodoDividerImplCopyWithImpl<$Res>
    extends _$TodoItemCopyWithImpl<$Res, _$TodoDividerImpl>
    implements _$$TodoDividerImplCopyWith<$Res> {
  __$$TodoDividerImplCopyWithImpl(
      _$TodoDividerImpl _value, $Res Function(_$TodoDividerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? index = null,
    Object? createdAt = null,
  }) {
    return _then(_$TodoDividerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoDividerImpl implements TodoDivider {
  const _$TodoDividerImpl(
      {required this.id,
      required this.index,
      @TimestampConverter() required this.createdAt,
      final String? $type})
      : $type = $type ?? 'divider';

  factory _$TodoDividerImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoDividerImplFromJson(json);

  @override
  final String id;
  @override
  final int index;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'TodoItem.divider(id: $id, index: $index, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoDividerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, index, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoDividerImplCopyWith<_$TodoDividerImpl> get copyWith =>
      __$$TodoDividerImplCopyWithImpl<_$TodoDividerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String title,
            bool isDone,
            int indentLevel,
            int index,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) {
    return divider(id, index, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, bool isDone, int indentLevel,
            int index, @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) {
    return divider?.call(id, index, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, bool isDone, int indentLevel,
            int index, @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
    required TResult orElse(),
  }) {
    if (divider != null) {
      return divider(id, index, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Todo value) todo,
    required TResult Function(TodoDivider value) divider,
  }) {
    return divider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Todo value)? todo,
    TResult? Function(TodoDivider value)? divider,
  }) {
    return divider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Todo value)? todo,
    TResult Function(TodoDivider value)? divider,
    required TResult orElse(),
  }) {
    if (divider != null) {
      return divider(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoDividerImplToJson(
      this,
    );
  }
}

abstract class TodoDivider implements TodoItem {
  const factory TodoDivider(
          {required final String id,
          required final int index,
          @TimestampConverter() required final DateTime createdAt}) =
      _$TodoDividerImpl;

  factory TodoDivider.fromJson(Map<String, dynamic> json) =
      _$TodoDividerImpl.fromJson;

  @override
  String get id;
  @override
  int get index;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$TodoDividerImplCopyWith<_$TodoDividerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
