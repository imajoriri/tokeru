// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppChatItemImpl _$$AppChatItemImplFromJson(Map<String, dynamic> json) =>
    _$AppChatItemImpl(
      id: json['id'] as String,
      message: json['message'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AppChatItemImplToJson(_$AppChatItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'type': instance.$type,
    };

_$AppTodoItemImpl _$$AppTodoItemImplFromJson(Map<String, dynamic> json) =>
    _$AppTodoItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool,
      index: (json['index'] as num).toInt(),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$AppTodoItemImplToJson(_$AppTodoItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
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
