// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubTaskModel _$SubTaskModelFromJson(Map<String, dynamic> json) => SubTaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: json['is_completed'] as bool? ?? false,
      idMaster: json['id_master'] as String,
    );

Map<String, dynamic> _$SubTaskModelToJson(SubTaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'is_completed': instance.isCompleted,
      'id_master': instance.idMaster,
    };
