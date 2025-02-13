// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      deadline: _$JsonConverterFromJson<String, DateTime>(
          json['deadline'], const DateTimeConverter().fromJson),
      completedDate: _$JsonConverterFromJson<String, DateTime>(
          json['completed_date'], const DateTimeConverter().fromJson),
      isCompleted: json['is_completed'] == null
          ? false
          : const BoolConverter().fromJson(json['is_completed']),
      subTasks: (json['sub_tasks'] as List<dynamic>?)
          ?.map((e) => SubTaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'is_completed': const BoolConverter().toJson(instance.isCompleted),
      'deadline': _$JsonConverterToJson<String, DateTime>(
          instance.deadline, const DateTimeConverter().toJson),
      'completed_date': _$JsonConverterToJson<String, DateTime>(
          instance.completedDate, const DateTimeConverter().toJson),
      'sub_tasks': instance.subTasks,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
