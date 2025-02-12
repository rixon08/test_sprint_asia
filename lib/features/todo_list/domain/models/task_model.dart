import 'package:json_annotation/json_annotation.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/sub_task_model.dart';

part 'task_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TaskModel {
  String id;
  String title;
  bool isCompleted;
  DateTime? deadline;
  DateTime? completedDate;
  List<SubTaskModel>? subTasks;

  bool get isHasSubTaks => subTasks != null && subTasks!.isNotEmpty;

  int get precentageCompletedSubTask {
    if (isHasSubTaks) {
      var completedSubTask = subTasks!.where((e) => e.isCompleted).toList();
      return ((completedSubTask.length / subTasks!.length) * 100).round();
    }
    return 0;
  }

  TaskModel(
      {required this.id,
      required this.title,
      this.deadline,
      this.completedDate,
      this.isCompleted = false,
      this.subTasks});

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
