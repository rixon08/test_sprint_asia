part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListEvent {}

final class TodoListInitialEvent extends TodoListEvent {}

final class TodoListGetOnGoingTaskEvent extends TodoListEvent {
  final DateTime selectDateTask;

  TodoListGetOnGoingTaskEvent(this.selectDateTask);
}

final class TodoListCheckTaskEvent extends TodoListEvent {
  final TaskModel taskModel;
  final DateTime selectDateTask;

  TodoListCheckTaskEvent(this.taskModel, this.selectDateTask);
}

final class TodoListCheckSubTaskEvent extends TodoListEvent {
  final SubTaskModel taskModel;
  final DateTime selectDateTask;

  TodoListCheckSubTaskEvent(this.taskModel, this.selectDateTask);
}

final class TodoListAddTaskEvent extends TodoListEvent {
  final TaskModel taskModel;
  final DateTime selectDateTask;

  TodoListAddTaskEvent(this.taskModel, this.selectDateTask);
}

final class TodoListAddSubTaskEvent extends TodoListEvent {
  final SubTaskModel taskModel;
  final DateTime selectDateTask;

  TodoListAddSubTaskEvent(this.taskModel, this.selectDateTask);
}

final class TodoListUpdateTaskEvent extends TodoListEvent {
  final TaskModel taskModel;
  final DateTime selectDateTask;

  TodoListUpdateTaskEvent(this.taskModel, this.selectDateTask);
}

final class TodoListUpdateSubTaskEvent extends TodoListEvent {
  final SubTaskModel taskModel;
  final DateTime selectDateTask;

  TodoListUpdateSubTaskEvent(this.taskModel, this.selectDateTask);
}

final class TodoListDeleteTaskEvent extends TodoListEvent {
  final TaskModel taskModel;
  final DateTime selectDateTask;

  TodoListDeleteTaskEvent(this.taskModel, this.selectDateTask);
}

final class TodoListDeleteSubTaskEvent extends TodoListEvent {
  final SubTaskModel taskModel;
  final DateTime selectDateTask;

  TodoListDeleteSubTaskEvent(this.taskModel, this.selectDateTask);
}

final class TodoListTabOnGoingTaskEvent extends TodoListEvent {
  final DateTime selectDateTask;

  TodoListTabOnGoingTaskEvent(this.selectDateTask);
}

final class TodoListTabCompleteTaskEvent extends TodoListEvent {
  final DateTime selectDateTask;

  TodoListTabCompleteTaskEvent(this.selectDateTask);
}
