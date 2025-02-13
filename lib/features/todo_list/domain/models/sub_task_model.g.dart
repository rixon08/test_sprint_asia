// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubTaskModel _$SubTaskModelFromJson(Map<String, dynamic> json) => SubTaskModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      isCompleted: json['is_completed'] == null
          ? false
          : const BoolConverter().fromJson(json['is_completed']),
      idMaster: (json['id_master'] as num).toInt(),
    );

Map<String, dynamic> _$SubTaskModelToJson(SubTaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'is_completed': const BoolConverter().toJson(instance.isCompleted),
      'id_master': instance.idMaster,
    };
