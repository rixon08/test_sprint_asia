part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListEvent {}

final class TodoListInitialEvent extends TodoListEvent {}

final class TodoListGetOnGoingTaskEvent extends TodoListEvent {}

final class TodoListCheckTaskEvent extends TodoListEvent {
  final TaskModel taskModel;

  TodoListCheckTaskEvent(this.taskModel);
}

final class TodoListCheckSubTaskEvent extends TodoListEvent {
  final TaskModel taskModel;

  TodoListCheckSubTaskEvent(this.taskModel);
}
