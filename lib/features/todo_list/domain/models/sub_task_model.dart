import 'package:json_annotation/json_annotation.dart';
import 'package:test_sprint_asia/core/utils/convert/bool_converter_json.dart';

part 'sub_task_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SubTaskModel {
  int id;
  String title;
  @BoolConverter()
  bool isCompleted;
  int idMaster;

  SubTaskModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.idMaster
  });

  factory SubTaskModel.fromJson(Map<String, dynamic> json) =>
      _$SubTaskModelFromJson(json);
}