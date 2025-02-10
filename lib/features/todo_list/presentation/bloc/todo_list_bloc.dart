import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/get_all_on_going_task.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_check_sub_task.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_check_task.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  GetAllOnGoingTask getAllOnGoingTask;
  UpdateCheckTask updateCheckTask;
  UpdateCheckSubTask updateCheckSubTask;
  TodoListBloc(this.getAllOnGoingTask, this.updateCheckTask, this.updateCheckSubTask) : super(TodoListInitialState()) {
    on<TodoListInitialEvent>((event, emit) {
        
    }); 
    on<TodoListGetOnGoingTaskEvent>((event, emit) async {
      var result = await getAllOnGoingTask.call(DateTime.now());
      if (result.isSuccess){
        emit(TodoListGetOnGoingTaskCompletedState(result.data!));
      }
    });
    on<TodoListCheckTaskEvent>((event, emit) async {
      var result = await updateCheckTask(event.taskModel);
      if (result.isSuccess){
        await getOnGoingTask(emit);
      }
    }); 
    on<TodoListCheckSubTaskEvent>((event, emit) {
        
    }); 
  }

  Future<void> getOnGoingTask(Emitter<TodoListState> emit) async {
    var result = await getAllOnGoingTask.call(DateTime.now());
    if (result.isSuccess){
      emit(TodoListGetOnGoingTaskCompletedState(result.data!));
    }
  }
}
