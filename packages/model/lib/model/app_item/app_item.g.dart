// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppChatItemImpl _$$AppChatItemImplFromJson(Map<String, dynamic> json) =>
    _$AppChatItemImpl(
      id: json['id'] as String,
      message: json['message'] as String,
      threadCount: (json['threadCount'] as num?)?.toInt() ?? 0,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AppChatItemImplToJson(_$AppChatItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'threadCount': instance.threadCount,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'type': instance.$type,
    };

_$AppThreadItemImpl _$$AppThreadItemImplFromJson(Map<String, dynamic> json) =>
    _$AppThreadItemImpl(
      id: json['id'] as String,
      message: json['message'] as String,
      parentId: json['parentId'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AppThreadItemImplToJson(_$AppThreadItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'parentId': instance.parentId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'type': instance.$type,
    };

_$AppAiCommentItemImpl _$$AppAiCommentItemImplFromJson(
        Map<String, dynamic> json) =>
    _$AppAiCommentItemImpl(
      id: json['id'] as String,
      userMessage: json['userMessage'] as String,
      aiMessage: json['aiMessage'] as String,
      parentId: json['parentId'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AppAiCommentItemImplToJson(
        _$AppAiCommentItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userMessage': instance.userMessage,
      'aiMessage': instance.aiMessage,
      'parentId': instance.parentId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'type': instance.$type,
    };

_$AppTodoItemImpl _$$AppTodoItemImplFromJson(Map<String, dynamic> json) =>
    _$AppTodoItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String? ?? '',
      isDone: json['isDone'] as bool,
      index: (json['index'] as num).toInt(),
      threadCount: (json['threadCount'] as num?)?.toInt() ?? 0,
      subTodoCount: (json['subTodoCount'] as num?)?.toInt() ?? 0,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AppTodoItemImplToJson(_$AppTodoItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'isDone': instance.isDone,
      'index': instance.index,
      'threadCount': instance.threadCount,
      'subTodoCount': instance.subTodoCount,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'type': instance.$type,
    };

_$AppSubTodoItemImpl _$$AppSubTodoItemImplFromJson(Map<String, dynamic> json) =>
    _$AppSubTodoItemImpl(
      id: json['id'] as String,
      parentId: json['parentId'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool,
      index: (json['index'] as num).toInt(),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AppSubTodoItemImplToJson(
        _$AppSubTodoItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentId': instance.parentId,
      'title': instance.title,
      'isDone': instance.isDone,
      'index': instance.index,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'type': instance.$type,
    };

_$AppDividerItemImpl _$$AppDividerItemImplFromJson(Map<String, dynamic> json) =>
    _$AppDividerItemImpl(
      id: json['id'] as String,
      index: (json['index'] as num).toInt(),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AppDividerItemImplToJson(
        _$AppDividerItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'type': instance.$type,
    };
