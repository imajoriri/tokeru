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
    case 'ai_comment':
      return AppAiCommentItem.fromJson(json);
    case 'todo':
      return AppTodoItem.fromJson(json);
    case 'sub_todo':
      return AppSubTodoItem.fromJson(json);
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
    required TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)
        chat,
    required TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)
        thread,
    required TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)
        aiComment,
    required TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(String id, String parentId, String title,
            bool isDone, int index, @TimestampConverter() DateTime createdAt)
        subTodo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult? Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult? Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult? Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
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
    required TResult Function(AppAiCommentItem value) aiComment,
    required TResult Function(AppTodoItem value) todo,
    required TResult Function(AppSubTodoItem value) subTodo,
    required TResult Function(AppDividerItem value) divider,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppChatItem value)? chat,
    TResult? Function(AppThreadItem value)? thread,
    TResult? Function(AppAiCommentItem value)? aiComment,
    TResult? Function(AppTodoItem value)? todo,
    TResult? Function(AppSubTodoItem value)? subTodo,
    TResult? Function(AppDividerItem value)? divider,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppChatItem value)? chat,
    TResult Function(AppThreadItem value)? thread,
    TResult Function(AppAiCommentItem value)? aiComment,
    TResult Function(AppTodoItem value)? todo,
    TResult Function(AppSubTodoItem value)? subTodo,
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
      {String id,
      String message,
      int threadCount,
      @TimestampConverter() DateTime createdAt});
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
    Object? threadCount = null,
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
      threadCount: null == threadCount
          ? _value.threadCount
          : threadCount // ignore: cast_nullable_to_non_nullable
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
class _$AppChatItemImpl implements AppChatItem {
  const _$AppChatItemImpl(
      {required this.id,
      required this.message,
      this.threadCount = 0,
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

  /// スレッドの件数。
  @override
  @JsonKey()
  final int threadCount;

  /// 作成日時。
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'AppItem.chat(id: $id, message: $message, threadCount: $threadCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppChatItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.threadCount, threadCount) ||
                other.threadCount == threadCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, message, threadCount, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppChatItemImplCopyWith<_$AppChatItemImpl> get copyWith =>
      __$$AppChatItemImplCopyWithImpl<_$AppChatItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)
        chat,
    required TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)
        thread,
    required TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)
        aiComment,
    required TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(String id, String parentId, String title,
            bool isDone, int index, @TimestampConverter() DateTime createdAt)
        subTodo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) {
    return chat(id, message, threadCount, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult? Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult? Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult? Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) {
    return chat?.call(id, message, threadCount, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
    TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
    required TResult orElse(),
  }) {
    if (chat != null) {
      return chat(id, message, threadCount, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppChatItem value) chat,
    required TResult Function(AppThreadItem value) thread,
    required TResult Function(AppAiCommentItem value) aiComment,
    required TResult Function(AppTodoItem value) todo,
    required TResult Function(AppSubTodoItem value) subTodo,
    required TResult Function(AppDividerItem value) divider,
  }) {
    return chat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppChatItem value)? chat,
    TResult? Function(AppThreadItem value)? thread,
    TResult? Function(AppAiCommentItem value)? aiComment,
    TResult? Function(AppTodoItem value)? todo,
    TResult? Function(AppSubTodoItem value)? subTodo,
    TResult? Function(AppDividerItem value)? divider,
  }) {
    return chat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppChatItem value)? chat,
    TResult Function(AppThreadItem value)? thread,
    TResult Function(AppAiCommentItem value)? aiComment,
    TResult Function(AppTodoItem value)? todo,
    TResult Function(AppSubTodoItem value)? subTodo,
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
          final int threadCount,
          @TimestampConverter() required final DateTime createdAt}) =
      _$AppChatItemImpl;

  factory AppChatItem.fromJson(Map<String, dynamic> json) =
      _$AppChatItemImpl.fromJson;

  @override

  /// ID。
  String get id;

  /// メッセージ。
  String get message;

  /// スレッドの件数。
  int get threadCount;
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
    required TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)
        chat,
    required TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)
        thread,
    required TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)
        aiComment,
    required TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(String id, String parentId, String title,
            bool isDone, int index, @TimestampConverter() DateTime createdAt)
        subTodo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) {
    return thread(id, message, parentId, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult? Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult? Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult? Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) {
    return thread?.call(id, message, parentId, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
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
    required TResult Function(AppAiCommentItem value) aiComment,
    required TResult Function(AppTodoItem value) todo,
    required TResult Function(AppSubTodoItem value) subTodo,
    required TResult Function(AppDividerItem value) divider,
  }) {
    return thread(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppChatItem value)? chat,
    TResult? Function(AppThreadItem value)? thread,
    TResult? Function(AppAiCommentItem value)? aiComment,
    TResult? Function(AppTodoItem value)? todo,
    TResult? Function(AppSubTodoItem value)? subTodo,
    TResult? Function(AppDividerItem value)? divider,
  }) {
    return thread?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppChatItem value)? chat,
    TResult Function(AppThreadItem value)? thread,
    TResult Function(AppAiCommentItem value)? aiComment,
    TResult Function(AppTodoItem value)? todo,
    TResult Function(AppSubTodoItem value)? subTodo,
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
abstract class _$$AppAiCommentItemImplCopyWith<$Res>
    implements $AppItemCopyWith<$Res> {
  factory _$$AppAiCommentItemImplCopyWith(_$AppAiCommentItemImpl value,
          $Res Function(_$AppAiCommentItemImpl) then) =
      __$$AppAiCommentItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userMessage,
      String aiMessage,
      String parentId,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$AppAiCommentItemImplCopyWithImpl<$Res>
    extends _$AppItemCopyWithImpl<$Res, _$AppAiCommentItemImpl>
    implements _$$AppAiCommentItemImplCopyWith<$Res> {
  __$$AppAiCommentItemImplCopyWithImpl(_$AppAiCommentItemImpl _value,
      $Res Function(_$AppAiCommentItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userMessage = null,
    Object? aiMessage = null,
    Object? parentId = null,
    Object? createdAt = null,
  }) {
    return _then(_$AppAiCommentItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userMessage: null == userMessage
          ? _value.userMessage
          : userMessage // ignore: cast_nullable_to_non_nullable
              as String,
      aiMessage: null == aiMessage
          ? _value.aiMessage
          : aiMessage // ignore: cast_nullable_to_non_nullable
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
class _$AppAiCommentItemImpl implements AppAiCommentItem {
  const _$AppAiCommentItemImpl(
      {required this.id,
      required this.userMessage,
      required this.aiMessage,
      required this.parentId,
      @TimestampConverter() required this.createdAt,
      final String? $type})
      : $type = $type ?? 'ai_comment';

  factory _$AppAiCommentItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppAiCommentItemImplFromJson(json);

  /// ID。
  @override
  final String id;

  /// ユーザーが入力したメッセージ。
  @override
  final String userMessage;

  /// AIのメッセージ。
  @override
  final String aiMessage;

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
    return 'AppItem.aiComment(id: $id, userMessage: $userMessage, aiMessage: $aiMessage, parentId: $parentId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppAiCommentItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userMessage, userMessage) ||
                other.userMessage == userMessage) &&
            (identical(other.aiMessage, aiMessage) ||
                other.aiMessage == aiMessage) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userMessage, aiMessage, parentId, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppAiCommentItemImplCopyWith<_$AppAiCommentItemImpl> get copyWith =>
      __$$AppAiCommentItemImplCopyWithImpl<_$AppAiCommentItemImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)
        chat,
    required TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)
        thread,
    required TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)
        aiComment,
    required TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(String id, String parentId, String title,
            bool isDone, int index, @TimestampConverter() DateTime createdAt)
        subTodo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) {
    return aiComment(id, userMessage, aiMessage, parentId, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult? Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult? Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult? Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) {
    return aiComment?.call(id, userMessage, aiMessage, parentId, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
    TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
    required TResult orElse(),
  }) {
    if (aiComment != null) {
      return aiComment(id, userMessage, aiMessage, parentId, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppChatItem value) chat,
    required TResult Function(AppThreadItem value) thread,
    required TResult Function(AppAiCommentItem value) aiComment,
    required TResult Function(AppTodoItem value) todo,
    required TResult Function(AppSubTodoItem value) subTodo,
    required TResult Function(AppDividerItem value) divider,
  }) {
    return aiComment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppChatItem value)? chat,
    TResult? Function(AppThreadItem value)? thread,
    TResult? Function(AppAiCommentItem value)? aiComment,
    TResult? Function(AppTodoItem value)? todo,
    TResult? Function(AppSubTodoItem value)? subTodo,
    TResult? Function(AppDividerItem value)? divider,
  }) {
    return aiComment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppChatItem value)? chat,
    TResult Function(AppThreadItem value)? thread,
    TResult Function(AppAiCommentItem value)? aiComment,
    TResult Function(AppTodoItem value)? todo,
    TResult Function(AppSubTodoItem value)? subTodo,
    TResult Function(AppDividerItem value)? divider,
    required TResult orElse(),
  }) {
    if (aiComment != null) {
      return aiComment(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AppAiCommentItemImplToJson(
      this,
    );
  }
}

abstract class AppAiCommentItem implements AppItem {
  const factory AppAiCommentItem(
          {required final String id,
          required final String userMessage,
          required final String aiMessage,
          required final String parentId,
          @TimestampConverter() required final DateTime createdAt}) =
      _$AppAiCommentItemImpl;

  factory AppAiCommentItem.fromJson(Map<String, dynamic> json) =
      _$AppAiCommentItemImpl.fromJson;

  @override

  /// ID。
  String get id;

  /// ユーザーが入力したメッセージ。
  String get userMessage;

  /// AIのメッセージ。
  String get aiMessage;

  /// 親の[AppItem.id]ID。
  String get parentId;
  @override

  /// 作成日時。
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AppAiCommentItemImplCopyWith<_$AppAiCommentItemImpl> get copyWith =>
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
      int threadCount,
      int subTodoCount,
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
    Object? threadCount = null,
    Object? subTodoCount = null,
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
      threadCount: null == threadCount
          ? _value.threadCount
          : threadCount // ignore: cast_nullable_to_non_nullable
              as int,
      subTodoCount: null == subTodoCount
          ? _value.subTodoCount
          : subTodoCount // ignore: cast_nullable_to_non_nullable
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
      this.threadCount = 0,
      this.subTodoCount = 0,
      @TimestampConverter() required this.createdAt,
      final String? $type})
      : $type = $type ?? 'todo';

  factory _$AppTodoItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppTodoItemImplFromJson(json);

  /// ID。
  @override
  final String id;

  /// タイトル。
  @override
  final String title;

  /// 完了フラグ。
  @override
  final bool isDone;

  /// インデックス。
  @override
  final int index;

  /// スレッドの件数。
  @override
  @JsonKey()
  final int threadCount;

  /// サブTodoの件数。
  @override
  @JsonKey()
  final int subTodoCount;

  /// 作成日時。
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'AppItem.todo(id: $id, title: $title, isDone: $isDone, index: $index, threadCount: $threadCount, subTodoCount: $subTodoCount, createdAt: $createdAt)';
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
            (identical(other.threadCount, threadCount) ||
                other.threadCount == threadCount) &&
            (identical(other.subTodoCount, subTodoCount) ||
                other.subTodoCount == subTodoCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, isDone, index,
      threadCount, subTodoCount, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppTodoItemImplCopyWith<_$AppTodoItemImpl> get copyWith =>
      __$$AppTodoItemImplCopyWithImpl<_$AppTodoItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)
        chat,
    required TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)
        thread,
    required TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)
        aiComment,
    required TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(String id, String parentId, String title,
            bool isDone, int index, @TimestampConverter() DateTime createdAt)
        subTodo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) {
    return todo(id, title, isDone, index, threadCount, subTodoCount, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult? Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult? Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult? Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) {
    return todo?.call(
        id, title, isDone, index, threadCount, subTodoCount, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
    TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
    required TResult orElse(),
  }) {
    if (todo != null) {
      return todo(
          id, title, isDone, index, threadCount, subTodoCount, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppChatItem value) chat,
    required TResult Function(AppThreadItem value) thread,
    required TResult Function(AppAiCommentItem value) aiComment,
    required TResult Function(AppTodoItem value) todo,
    required TResult Function(AppSubTodoItem value) subTodo,
    required TResult Function(AppDividerItem value) divider,
  }) {
    return todo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppChatItem value)? chat,
    TResult? Function(AppThreadItem value)? thread,
    TResult? Function(AppAiCommentItem value)? aiComment,
    TResult? Function(AppTodoItem value)? todo,
    TResult? Function(AppSubTodoItem value)? subTodo,
    TResult? Function(AppDividerItem value)? divider,
  }) {
    return todo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppChatItem value)? chat,
    TResult Function(AppThreadItem value)? thread,
    TResult Function(AppAiCommentItem value)? aiComment,
    TResult Function(AppTodoItem value)? todo,
    TResult Function(AppSubTodoItem value)? subTodo,
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
          final int threadCount,
          final int subTodoCount,
          @TimestampConverter() required final DateTime createdAt}) =
      _$AppTodoItemImpl;

  factory AppTodoItem.fromJson(Map<String, dynamic> json) =
      _$AppTodoItemImpl.fromJson;

  @override

  /// ID。
  String get id;

  /// タイトル。
  String get title;

  /// 完了フラグ。
  bool get isDone;

  /// インデックス。
  int get index;

  /// スレッドの件数。
  int get threadCount;

  /// サブTodoの件数。
  int get subTodoCount;
  @override

  /// 作成日時。
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AppTodoItemImplCopyWith<_$AppTodoItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AppSubTodoItemImplCopyWith<$Res>
    implements $AppItemCopyWith<$Res> {
  factory _$$AppSubTodoItemImplCopyWith(_$AppSubTodoItemImpl value,
          $Res Function(_$AppSubTodoItemImpl) then) =
      __$$AppSubTodoItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String parentId,
      String title,
      bool isDone,
      int index,
      @TimestampConverter() DateTime createdAt});
}

/// @nodoc
class __$$AppSubTodoItemImplCopyWithImpl<$Res>
    extends _$AppItemCopyWithImpl<$Res, _$AppSubTodoItemImpl>
    implements _$$AppSubTodoItemImplCopyWith<$Res> {
  __$$AppSubTodoItemImplCopyWithImpl(
      _$AppSubTodoItemImpl _value, $Res Function(_$AppSubTodoItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentId = null,
    Object? title = null,
    Object? isDone = null,
    Object? index = null,
    Object? createdAt = null,
  }) {
    return _then(_$AppSubTodoItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
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
class _$AppSubTodoItemImpl implements AppSubTodoItem {
  const _$AppSubTodoItemImpl(
      {required this.id,
      required this.parentId,
      required this.title,
      required this.isDone,
      required this.index,
      @TimestampConverter() required this.createdAt,
      final String? $type})
      : $type = $type ?? 'sub_todo';

  factory _$AppSubTodoItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppSubTodoItemImplFromJson(json);

  /// ID。
  @override
  final String id;

  /// 親の[AppItem.id]ID。
  @override
  final String parentId;

  /// タイトル。
  @override
  final String title;

  /// 完了フラグ。
  @override
  final bool isDone;

  /// インデックス。
  @override
  final int index;

  /// 作成日時。
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'AppItem.subTodo(id: $id, parentId: $parentId, title: $title, isDone: $isDone, index: $index, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSubTodoItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isDone, isDone) || other.isDone == isDone) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, parentId, title, isDone, index, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSubTodoItemImplCopyWith<_$AppSubTodoItemImpl> get copyWith =>
      __$$AppSubTodoItemImplCopyWithImpl<_$AppSubTodoItemImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)
        chat,
    required TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)
        thread,
    required TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)
        aiComment,
    required TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(String id, String parentId, String title,
            bool isDone, int index, @TimestampConverter() DateTime createdAt)
        subTodo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) {
    return subTodo(id, parentId, title, isDone, index, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult? Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult? Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult? Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) {
    return subTodo?.call(id, parentId, title, isDone, index, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
    TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
    required TResult orElse(),
  }) {
    if (subTodo != null) {
      return subTodo(id, parentId, title, isDone, index, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppChatItem value) chat,
    required TResult Function(AppThreadItem value) thread,
    required TResult Function(AppAiCommentItem value) aiComment,
    required TResult Function(AppTodoItem value) todo,
    required TResult Function(AppSubTodoItem value) subTodo,
    required TResult Function(AppDividerItem value) divider,
  }) {
    return subTodo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppChatItem value)? chat,
    TResult? Function(AppThreadItem value)? thread,
    TResult? Function(AppAiCommentItem value)? aiComment,
    TResult? Function(AppTodoItem value)? todo,
    TResult? Function(AppSubTodoItem value)? subTodo,
    TResult? Function(AppDividerItem value)? divider,
  }) {
    return subTodo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppChatItem value)? chat,
    TResult Function(AppThreadItem value)? thread,
    TResult Function(AppAiCommentItem value)? aiComment,
    TResult Function(AppTodoItem value)? todo,
    TResult Function(AppSubTodoItem value)? subTodo,
    TResult Function(AppDividerItem value)? divider,
    required TResult orElse(),
  }) {
    if (subTodo != null) {
      return subTodo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AppSubTodoItemImplToJson(
      this,
    );
  }
}

abstract class AppSubTodoItem implements AppItem {
  const factory AppSubTodoItem(
          {required final String id,
          required final String parentId,
          required final String title,
          required final bool isDone,
          required final int index,
          @TimestampConverter() required final DateTime createdAt}) =
      _$AppSubTodoItemImpl;

  factory AppSubTodoItem.fromJson(Map<String, dynamic> json) =
      _$AppSubTodoItemImpl.fromJson;

  @override

  /// ID。
  String get id;

  /// 親の[AppItem.id]ID。
  String get parentId;

  /// タイトル。
  String get title;

  /// 完了フラグ。
  bool get isDone;

  /// インデックス。
  int get index;
  @override

  /// 作成日時。
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AppSubTodoItemImplCopyWith<_$AppSubTodoItemImpl> get copyWith =>
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
    required TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)
        chat,
    required TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)
        thread,
    required TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)
        aiComment,
    required TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)
        todo,
    required TResult Function(String id, String parentId, String title,
            bool isDone, int index, @TimestampConverter() DateTime createdAt)
        subTodo,
    required TResult Function(
            String id, int index, @TimestampConverter() DateTime createdAt)
        divider,
  }) {
    return divider(id, index, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult? Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult? Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult? Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult? Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
    TResult? Function(
            String id, int index, @TimestampConverter() DateTime createdAt)?
        divider,
  }) {
    return divider?.call(id, index, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String message, int threadCount,
            @TimestampConverter() DateTime createdAt)?
        chat,
    TResult Function(String id, String message, String parentId,
            @TimestampConverter() DateTime createdAt)?
        thread,
    TResult Function(String id, String userMessage, String aiMessage,
            String parentId, @TimestampConverter() DateTime createdAt)?
        aiComment,
    TResult Function(
            String id,
            String title,
            bool isDone,
            int index,
            int threadCount,
            int subTodoCount,
            @TimestampConverter() DateTime createdAt)?
        todo,
    TResult Function(String id, String parentId, String title, bool isDone,
            int index, @TimestampConverter() DateTime createdAt)?
        subTodo,
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
    required TResult Function(AppAiCommentItem value) aiComment,
    required TResult Function(AppTodoItem value) todo,
    required TResult Function(AppSubTodoItem value) subTodo,
    required TResult Function(AppDividerItem value) divider,
  }) {
    return divider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppChatItem value)? chat,
    TResult? Function(AppThreadItem value)? thread,
    TResult? Function(AppAiCommentItem value)? aiComment,
    TResult? Function(AppTodoItem value)? todo,
    TResult? Function(AppSubTodoItem value)? subTodo,
    TResult? Function(AppDividerItem value)? divider,
  }) {
    return divider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppChatItem value)? chat,
    TResult Function(AppThreadItem value)? thread,
    TResult Function(AppAiCommentItem value)? aiComment,
    TResult Function(AppTodoItem value)? todo,
    TResult Function(AppSubTodoItem value)? subTodo,
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
