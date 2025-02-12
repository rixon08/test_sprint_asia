part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListEvent {}

final class TodoListInitialEvent extends TodoListEvent {}

final class TodoListGetOnGoingTaskEvent extends TodoListEvent {
}

final class TodoListCheckTaskEvent extends TodoListEvent {
  final TaskModel taskModel;

  TodoListCheckTaskEvent(this.taskModel);
}

final class TodoListCheckSubTaskEvent extends TodoListEvent {
  final SubTaskModel taskModel;

  TodoListCheckSubTaskEvent(this.taskModel);
}

final class TodoListAddTaskEvent extends TodoListEvent {
  final TaskModel taskModel;

  TodoListAddTaskEvent(this.taskModel);
}

final class TodoListAddSubTaskEvent extends TodoListEvent {
  final SubTaskModel taskModel;

  TodoListAddSubTaskEvent(this.taskModel);
}

final class TodoListUpdateTaskEvent extends TodoListEvent {
  final TaskModel taskModel;

  TodoListUpdateTaskEvent(this.taskModel);
}

final class TodoListUpdateSubTaskEvent extends TodoListEvent {
  final SubTaskModel taskModel;

  TodoListUpdateSubTaskEvent(this.taskModel);
}

final class TodoListDeleteTaskEvent extends TodoListEvent {
  final TaskModel taskModel;

  TodoListDeleteTaskEvent(this.taskModel);
}

final class TodoListDeleteSubTaskEvent extends TodoListEvent {
  final SubTaskModel taskModel;

  TodoListDeleteSubTaskEvent(this.taskModel);
}

final class TodoListTabOnGoingTaskEvent extends TodoListEvent {

  TodoListTabOnGoingTaskEvent();
}

final class TodoListTabCompleteTaskEvent extends TodoListEvent {

  TodoListTabCompleteTaskEvent();
}
