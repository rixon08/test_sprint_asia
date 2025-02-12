// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      completedDate: json['completed_date'] == null
          ? null
          : DateTime.parse(json['completed_date'] as String),
      isCompleted: json['is_completed'] as bool? ?? false,
      subTasks: (json['sub_tasks'] as List<dynamic>?)
          ?.map((e) => SubTaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'is_completed': instance.isCompleted,
      'deadline': instance.deadline?.toIso8601String(),
      'completed_date': instance.completedDate?.toIso8601String(),
      'sub_tasks': instance.subTasks,
    };
