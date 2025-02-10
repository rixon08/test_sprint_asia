part of 'todo_list_bloc.dart';

@immutable
sealed class TodoListEvent {}

final class TodoListInitialEvent extends TodoListEvent {}
