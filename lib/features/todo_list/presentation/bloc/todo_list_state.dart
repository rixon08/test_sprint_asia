part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListState {}

final class TodoListInitialState extends TodoListState {
}

final class TodoListLoadingGetOnGoingTaskState extends TodoListState {
}

final class TodoListGetOnGoingTaskCompletedState extends TodoListState {
  final List<TaskModel> listTaskModel;

  TodoListGetOnGoingTaskCompletedState(this.listTaskModel);
}

final class TodoListLoadingGetCompletedTaskState extends TodoListState {
}

final class TodoListCompletedTaskCompletedState extends TodoListState {
  final List<TaskModel> listTaskModel;

  TodoListCompletedTaskCompletedState(this.listTaskModel);
}
