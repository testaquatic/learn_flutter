// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Todo _$TodoFromJson(Map<String, dynamic> json) => _Todo(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String? ?? "",
  completed: json['completed'] as bool? ?? false,
  createdAt: _jsonToDateTime(json['created_at'] as String),
  updatedAt: !json.containsKey('updated_at')
      ? null
      : _jsonToDateTimeNull(json['updated_at'] as String?),
  priority: json['priority'] as String? ?? "normal",
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$TodoToJson(_Todo instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'completed': instance.completed,
  'created_at': _datetimeToJson(instance.createdAt),
  if (instance.updatedAt case final value?)
    'updated_at': _datetimeNullToJson(value),
  'priority': instance.priority,
  'tags': instance.tags,
};
