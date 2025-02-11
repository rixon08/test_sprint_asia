import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/sub_task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/add_sub_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/add_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/delete_data_sub_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/delete_data_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/get_all_on_going_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_check_sub_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_check_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_data_sub_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_data_task_usecase.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  GetAllOnGoingTaskUseCase getAllOnGoingTask;
  UpdateCheckTaskUseCase updateCheckTask;
  UpdateCheckSubTaskUseCase updateCheckSubTask;
  AddTaskUseCase addTaskUseCase;
  AddSubTaskUseCase addSubTaskUseCase;
  DeleteDataTaskUseCase deleteDataTaskUseCase;
  DeleteDataSubTaskUseCase deleteDataSubTaskUseCase;
  UpdateDataTaskUseCase updateDataTaskUseCase;
  UpdateDataSubTaskUseCase updateDataSubTaskUseCase;
  TodoListBloc({
      required this.getAllOnGoingTask,
      required this.updateCheckTask,
      required this.addTaskUseCase,
      required this.addSubTaskUseCase,
      required this.updateCheckSubTask,
      required this.updateDataTaskUseCase,
      required this.updateDataSubTaskUseCase,
      required this.deleteDataTaskUseCase,
      required this.deleteDataSubTaskUseCase})
      : super(TodoListInitialState()) {
    on<TodoListInitialEvent>((event, emit) {});

    on<TodoListGetOnGoingTaskEvent>((event, emit) async {
      var result = await getAllOnGoingTask.call(event.selectDateTask);
      if (result.isSuccess) {
        emit(TodoListGetOnGoingTaskCompletedState(result.data!));
      }
    });

    on<TodoListCheckTaskEvent>((event, emit) async {
      var result = await updateCheckTask.call(event.taskModel);
      if (result.isSuccess) {
        await getOnGoingTask(emit, event.selectDateTask);
      }
    });

    on<TodoListCheckSubTaskEvent>((event, emit) async {
      var result = await updateCheckSubTask.call(event.taskModel);
      if (result.isSuccess) {
        await getOnGoingTask(emit, event.selectDateTask);
      }
    });

    on<TodoListAddTaskEvent>((event, emit) async {
      var result = await addTaskUseCase.call(event.taskModel);
      if (result.isSuccess) {
        await getOnGoingTask(emit, event.selectDateTask);
      }
    });

    on<TodoListAddSubTaskEvent>((event, emit) async {
      var result = await addSubTaskUseCase.call(event.taskModel);
      if (result.isSuccess) {
        await getOnGoingTask(emit, event.selectDateTask);
      }
    });

    on<TodoListUpdateTaskEvent>((event, emit) async {
      var result = await updateDataTaskUseCase.call(event.taskModel);
      if (result.isSuccess) {
        await getOnGoingTask(emit, event.selectDateTask);
      }
    });

    on<TodoListUpdateSubTaskEvent>((event, emit) async {
      var result = await updateDataSubTaskUseCase.call(event.taskModel);
      if (result.isSuccess) {
        await getOnGoingTask(emit, event.selectDateTask);
      }
    });

    on<TodoListDeleteTaskEvent>((event, emit) async {
      var result = await deleteDataTaskUseCase.call(event.taskModel);
      if (result.isSuccess) {
        await getOnGoingTask(emit, event.selectDateTask);
      }
    });

    on<TodoListDeleteSubTaskEvent>((event, emit) async {
      var result = await deleteDataSubTaskUseCase.call(event.taskModel);
      if (result.isSuccess) {
        await getOnGoingTask(emit, event.selectDateTask);
      }
    });

    on<TodoListTabOnGoingTaskEvent>((event, emit) async {
      emit(TodoListTabOnGoingTaskState());
    });

    on<TodoListTabCompleteTaskEvent>((event, emit) async {
      emit(TodoListTabCompletedTaskState());
    });
  }

  Future<void> getOnGoingTask(
      Emitter<TodoListState> emit, DateTime dateTime) async {
    var result = await getAllOnGoingTask.call(dateTime);
    if (result.isSuccess) {
      emit(TodoListGetOnGoingTaskCompletedState(result.data!));
    }
  }
}
