import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TaskModel {
  String title;
  bool isCompleted;
  DateTime date;
  DateTime? deadline;
  List<TaskModel>? subTasks;

  TaskModel(
      {required this.title,
      required this.date,
      this.deadline,
      this.isCompleted = false,
      this.subTasks});

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
