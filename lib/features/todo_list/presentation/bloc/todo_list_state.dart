part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListState {}

final class TodoListInitialState extends TodoListState {}

final class TodoListLoadingGetOnGoingTaskState extends TodoListState {}

final class TodoListLoadingGetOnGoingTaskCompletedState extends TodoListState {}

final class TodoListLoadingGetCompletedTaskState extends TodoListState {}

final class TodoListLoadingCompletedTaskCompletedState extends TodoListState {}
