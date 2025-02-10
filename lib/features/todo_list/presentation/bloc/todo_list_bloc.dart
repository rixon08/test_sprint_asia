import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListInitialState()) {
    on<TodoListInitialEvent>((event, emit) {
        
    }); 
  }
}
