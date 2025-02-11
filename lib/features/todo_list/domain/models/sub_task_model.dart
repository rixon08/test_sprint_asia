import 'package:json_annotation/json_annotation.dart';

part 'sub_task_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SubTaskModel {
  String id;
  String title;
  bool isCompleted;
  String idMaster;

  SubTaskModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.idMaster
  });

  factory SubTaskModel.fromJson(Map<String, dynamic> json) =>
      _$SubTaskModelFromJson(json);
}