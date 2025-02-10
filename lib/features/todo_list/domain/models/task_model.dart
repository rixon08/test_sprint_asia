import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TaskModel {
  String id;
  String title;
  bool isCompleted;
  DateTime date;
  DateTime? deadline;
  String? idMaster;
  List<TaskModel>? subTasks;

  TaskModel(
      {required this.id,
      required this.title,
      required this.date,
      this.deadline,
      this.isCompleted = false,
      this.subTasks,
      this.idMaster});

  TaskModel copyWith({bool? isCompleted, List<TaskModel>? subTasks}) {
    return TaskModel(
      id: id,
      title: title,
      date: date,
      isCompleted: isCompleted ?? this.isCompleted,
      subTasks: subTasks ?? this.subTasks,
      idMaster: idMaster
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
