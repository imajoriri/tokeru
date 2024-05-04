// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool,
      indentLevel: json['indentLevel'] as int,
      index: json['index'] as int,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isDone': instance.isDone,
      'indentLevel': instance.indentLevel,
      'index': instance.index,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'type': instance.$type,
    };

_$TodoDividerImpl _$$TodoDividerImplFromJson(Map<String, dynamic> json) =>
    _$TodoDividerImpl(
      id: json['id'] as String,
      index: json['index'] as int,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TodoDividerImplToJson(_$TodoDividerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'type': instance.$type,
    };
