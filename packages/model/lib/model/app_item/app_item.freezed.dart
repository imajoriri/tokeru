// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppItem _$AppItemFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'chat':
      return AppChatItem.fromJson(json);
    case 'thread':
      return AppThreadItem.fromJson(json);
    case 'todo':
      return AppTodoItem.fromJson(json);
    case 'divider':
      return AppDividerItem.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'AppItem', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$AppItem {
  /// ID。
  String get id => throw _privateConstructorUsedError;

  /// 作成日時。
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String message, @TimestampConverter() DateTime createdAt)
        chat,
    required TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)
        thread,
    required TResult Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String message,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult? Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult? Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String message,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppChatItem value) chat,
    required TResult Function(AppThreadItem value) thread,
    required TResult Function(AppTodoItem value) todo,
    required TResult Function(AppDividerItem value) divider,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppChatItem value)? chat,
    TResult? Function(AppThreadItem value)? thread,
    TResult? Function(AppTodoItem value)? todo,
    TResult? Function(AppDividerItem value)? divider,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppChatItem value)? chat,
    TResult Function(AppThreadItem value)? thread,
    TResult Function(AppTodoItem value)? todo,
    TResult Function(AppDividerItem value)? divider,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppItemCopyWith<AppItem> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppItemCopyWith<$Res> {
  factory $AppItemCopyWith(AppItem value, $Res Function(AppItem) then) =
      _$AppItemCopyWithImpl<$Res, AppItem>;
  @useResult
  $Res call({String id, @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class _$AppItemCopyWithImpl<$Res, $Val extends AppItem>
    implements $AppItemCopyWith<$Res> {
  _$AppItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppChatItemImplCopyWith<$Res>
    implements $AppItemCopyWith<$Res> {
  factory _$$AppChatItemImplCopyWith(
          _$AppChatItemImpl value, $Res Function(_$AppChatItemImpl) then) =
      __$$AppChatItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String message, @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$AppChatItemImplCopyWithImpl<$Res>
    extends _$AppItemCopyWithImpl<$Res, _$AppChatItemImpl>
    implements _$$AppChatItemImplCopyWith<$Res> {
  __$$AppChatItemImplCopyWithImpl(
      _$AppChatItemImpl _value, $Res Function(_$AppChatItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? message = null,
    Object? createdAt = null,
  }) {
    return _then(_$AppChatItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppChatItemImpl implements AppChatItem {
  const _$AppChatItemImpl(
      {required this.id,
      required this.message,
      @TimestampConverter() required this.createdAt,
      final String? $type})
      : $type = $type ?? 'chat';

  factory _$AppChatItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppChatItemImplFromJson(json);

  /// ID。
  @override
  final String id;

  /// メッセージ。
  @override
  final String message;

  /// 作成日時。
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'AppItem.chat(id: $id, message: $message, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppChatItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, message, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppChatItemImplCopyWith<_$AppChatItemImpl> get copyWith =>
      __$$AppChatItemImplCopyWithImpl<_$AppChatItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String message, @TimestampConverter() DateTime createdAt)
        chat,
    required TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)
        thread,
    required TResult Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) {
    return chat(id, message, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String message,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult? Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult? Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) {
    return chat?.call(id, message, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String message,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
    required TResult orElse(),
  }) {
    if (chat != null) {
      return chat(id, message, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppChatItem value) chat,
    required TResult Function(AppThreadItem value) thread,
    required TResult Function(AppTodoItem value) todo,
    required TResult Function(AppDividerItem value) divider,
  }) {
    return chat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppChatItem value)? chat,
    TResult? Function(AppThreadItem value)? thread,
    TResult? Function(AppTodoItem value)? todo,
    TResult? Function(AppDividerItem value)? divider,
  }) {
    return chat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppChatItem value)? chat,
    TResult Function(AppThreadItem value)? thread,
    TResult Function(AppTodoItem value)? todo,
    TResult Function(AppDividerItem value)? divider,
    required TResult orElse(),
  }) {
    if (chat != null) {
      return chat(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AppChatItemImplToJson(
      this,
    );
  }
}

abstract class AppChatItem implements AppItem {
  const factory AppChatItem(
          {required final String id,
          required final String message,
          @TimestampConverter() required final DateTime createdAt}) =
      _$AppChatItemImpl;

  factory AppChatItem.fromJson(Map<String, dynamic> json) =
      _$AppChatItemImpl.fromJson;

  @override

  /// ID。
  String get id;

  /// メッセージ。
  String get message;
  @override

  /// 作成日時。
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AppChatItemImplCopyWith<_$AppChatItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppThreadItemImplCopyWith<$Res>
    implements $AppItemCopyWith<$Res> {
  factory _$$AppThreadItemImplCopyWith(
          _$AppThreadItemImpl value, $Res Function(_$AppThreadItemImpl) then) =
      __$$AppThreadItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String message,
      String parentId,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$AppThreadItemImplCopyWithImpl<$Res>
    extends _$AppItemCopyWithImpl<$Res, _$AppThreadItemImpl>
    implements _$$AppThreadItemImplCopyWith<$Res> {
  __$$AppThreadItemImplCopyWithImpl(
      _$AppThreadItemImpl _value, $Res Function(_$AppThreadItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? message = null,
    Object? parentId = null,
    Object? createdAt = null,
  }) {
    return _then(_$AppThreadItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppThreadItemImpl implements AppThreadItem {
  const _$AppThreadItemImpl(
      {required this.id,
      required this.message,
      required this.parentId,
      @TimestampConverter() required this.createdAt,
      final String? $type})
      : $type = $type ?? 'thread';

  factory _$AppThreadItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppThreadItemImplFromJson(json);

  /// ID。
  @override
  final String id;

  /// メッセージ。
  @override
  final String message;

  /// 親の[AppItem.id]ID。
  @override
  final String parentId;

  /// 作成日時。
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'AppItem.thread(id: $id, message: $message, parentId: $parentId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppThreadItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, message, parentId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppThreadItemImplCopyWith<_$AppThreadItemImpl> get copyWith =>
      __$$AppThreadItemImplCopyWithImpl<_$AppThreadItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String message, @TimestampConverter() DateTime createdAt)
        chat,
    required TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)
        thread,
    required TResult Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) {
    return thread(id, message, parentId, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String message,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult? Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult? Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) {
    return thread?.call(id, message, parentId, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String message,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
    required TResult orElse(),
  }) {
    if (thread != null) {
      return thread(id, message, parentId, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppChatItem value) chat,
    required TResult Function(AppThreadItem value) thread,
    required TResult Function(AppTodoItem value) todo,
    required TResult Function(AppDividerItem value) divider,
  }) {
    return thread(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppChatItem value)? chat,
    TResult? Function(AppThreadItem value)? thread,
    TResult? Function(AppTodoItem value)? todo,
    TResult? Function(AppDividerItem value)? divider,
  }) {
    return thread?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppChatItem value)? chat,
    TResult Function(AppThreadItem value)? thread,
    TResult Function(AppTodoItem value)? todo,
    TResult Function(AppDividerItem value)? divider,
    required TResult orElse(),
  }) {
    if (thread != null) {
      return thread(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AppThreadItemImplToJson(
      this,
    );
  }
}

abstract class AppThreadItem implements AppItem {
  const factory AppThreadItem(
          {required final String id,
          required final String message,
          required final String parentId,
          @TimestampConverter() required final DateTime createdAt}) =
      _$AppThreadItemImpl;

  factory AppThreadItem.fromJson(Map<String, dynamic> json) =
      _$AppThreadItemImpl.fromJson;

  @override

  /// ID。
  String get id;

  /// メッセージ。
  String get message;

  /// 親の[AppItem.id]ID。
  String get parentId;
  @override

  /// 作成日時。
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AppThreadItemImplCopyWith<_$AppThreadItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppTodoItemImplCopyWith<$Res>
    implements $AppItemCopyWith<$Res> {
  factory _$$AppTodoItemImplCopyWith(
          _$AppTodoItemImpl value, $Res Function(_$AppTodoItemImpl) then) =
      __$$AppTodoItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      bool isDone,
      int index,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$AppTodoItemImplCopyWithImpl<$Res>
    extends _$AppItemCopyWithImpl<$Res, _$AppTodoItemImpl>
    implements _$$AppTodoItemImplCopyWith<$Res> {
  __$$AppTodoItemImplCopyWithImpl(
      _$AppTodoItemImpl _value, $Res Function(_$AppTodoItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? isDone = null,
    Object? index = null,
    Object? createdAt = null,
  }) {
    return _then(_$AppTodoItemImpl(
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
class _$AppTodoItemImpl implements AppTodoItem {
  const _$AppTodoItemImpl(
      {required this.id,
      required this.title,
      required this.isDone,
      required this.index,
      @TimestampConverter() required this.createdAt,
      final String? $type})
      : $type = $type ?? 'todo';

  factory _$AppTodoItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppTodoItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final bool isDone;
  @override
  final int index;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'AppItem.todo(id: $id, title: $title, isDone: $isDone, index: $index, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppTodoItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isDone, isDone) || other.isDone == isDone) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, isDone, index, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppTodoItemImplCopyWith<_$AppTodoItemImpl> get copyWith =>
      __$$AppTodoItemImplCopyWithImpl<_$AppTodoItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String message, @TimestampConverter() DateTime createdAt)
        chat,
    required TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)
        thread,
    required TResult Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) {
    return todo(id, title, isDone, index, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String message,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult? Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult? Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) {
    return todo?.call(id, title, isDone, index, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String message,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
    required TResult orElse(),
  }) {
    if (todo != null) {
      return todo(id, title, isDone, index, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppChatItem value) chat,
    required TResult Function(AppThreadItem value) thread,
    required TResult Function(AppTodoItem value) todo,
    required TResult Function(AppDividerItem value) divider,
  }) {
    return todo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppChatItem value)? chat,
    TResult? Function(AppThreadItem value)? thread,
    TResult? Function(AppTodoItem value)? todo,
    TResult? Function(AppDividerItem value)? divider,
  }) {
    return todo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppChatItem value)? chat,
    TResult Function(AppThreadItem value)? thread,
    TResult Function(AppTodoItem value)? todo,
    TResult Function(AppDividerItem value)? divider,
    required TResult orElse(),
  }) {
    if (todo != null) {
      return todo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AppTodoItemImplToJson(
      this,
    );
  }
}

abstract class AppTodoItem implements AppItem {
  const factory AppTodoItem(
          {required final String id,
          required final String title,
          required final bool isDone,
          required final int index,
          @TimestampConverter() required final DateTime createdAt}) =
      _$AppTodoItemImpl;

  factory AppTodoItem.fromJson(Map<String, dynamic> json) =
      _$AppTodoItemImpl.fromJson;

  @override
  String get id;
  String get title;
  bool get isDone;
  int get index;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AppTodoItemImplCopyWith<_$AppTodoItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppDividerItemImplCopyWith<$Res>
    implements $AppItemCopyWith<$Res> {
  factory _$$AppDividerItemImplCopyWith(_$AppDividerItemImpl value,
          $Res Function(_$AppDividerItemImpl) then) =
      __$$AppDividerItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, int index, @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$AppDividerItemImplCopyWithImpl<$Res>
    extends _$AppItemCopyWithImpl<$Res, _$AppDividerItemImpl>
    implements _$$AppDividerItemImplCopyWith<$Res> {
  __$$AppDividerItemImplCopyWithImpl(
      _$AppDividerItemImpl _value, $Res Function(_$AppDividerItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? index = null,
    Object? createdAt = null,
  }) {
    return _then(_$AppDividerItemImpl(
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
class _$AppDividerItemImpl implements AppDividerItem {
  const _$AppDividerItemImpl(
      {required this.id,
      required this.index,
      @TimestampConverter() required this.createdAt,
      final String? $type})
      : $type = $type ?? 'divider';

  factory _$AppDividerItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppDividerItemImplFromJson(json);

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
    return 'AppItem.divider(id: $id, index: $index, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppDividerItemImpl &&
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
  _$$AppDividerItemImplCopyWith<_$AppDividerItemImpl> get copyWith =>
      __$$AppDividerItemImplCopyWithImpl<_$AppDividerItemImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id, String message, @TimestampConverter() DateTime createdAt)
        chat,
    required TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)
        thread,
    required TResult Function(String id, String title, bool isDone, int index,
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
    TResult? Function(String id, String message,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult? Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult? Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)?
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
    TResult Function(String id, String message,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult Function(String id, String title, bool isDone, int index,
            @TimestampConverter() DateTime createdAt)?
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
    required TResult Function(AppChatItem value) chat,
    required TResult Function(AppThreadItem value) thread,
    required TResult Function(AppTodoItem value) todo,
    required TResult Function(AppDividerItem value) divider,
  }) {
    return divider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppChatItem value)? chat,
    TResult? Function(AppThreadItem value)? thread,
    TResult? Function(AppTodoItem value)? todo,
    TResult? Function(AppDividerItem value)? divider,
  }) {
    return divider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppChatItem value)? chat,
    TResult Function(AppThreadItem value)? thread,
    TResult Function(AppTodoItem value)? todo,
    TResult Function(AppDividerItem value)? divider,
    required TResult orElse(),
  }) {
    if (divider != null) {
      return divider(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AppDividerItemImplToJson(
      this,
    );
  }
}

abstract class AppDividerItem implements AppItem {
  const factory AppDividerItem(
          {required final String id,
          required final int index,
          @TimestampConverter() required final DateTime createdAt}) =
      _$AppDividerItemImpl;

  factory AppDividerItem.fromJson(Map<String, dynamic> json) =
      _$AppDividerItemImpl.fromJson;

  @override
  String get id;
  int get index;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AppDividerItemImplCopyWith<_$AppDividerItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
