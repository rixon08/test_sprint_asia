import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/sub_task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/add_sub_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/add_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/delete_data_sub_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/delete_data_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/get_all_completed_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/get_all_on_going_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_check_sub_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_check_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_data_sub_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_data_task_usecase.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  GetAllOnGoingTaskUseCase getAllOnGoingTask;
  GetAllCompletedTaskUseCase getAllCompletedTask;
  UpdateCheckTaskUseCase updateCheckTask;
  UpdateCheckSubTaskUseCase updateCheckSubTask;
  AddTaskUseCase addTaskUseCase;
  AddSubTaskUseCase addSubTaskUseCase;
  DeleteDataTaskUseCase deleteDataTaskUseCase;
  DeleteDataSubTaskUseCase deleteDataSubTaskUseCase;
  UpdateDataTaskUseCase updateDataTaskUseCase;
  UpdateDataSubTaskUseCase updateDataSubTaskUseCase;

  bool isTabCompletedTask = false;
  bool isTabOnGoingTask = true;

  TodoListBloc(
      {required this.getAllOnGoingTask,
      required this.getAllCompletedTask,
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
      emit(TodoListLoadingState());
      var result = await getAllOnGoingTask.call();
      if (result.isSuccess) {
        emit(TodoListGetOnGoingTaskCompletedState(result.data!));
      } else {
        emit(TodoListShowErrorMessageState(result.message));
      }
    });

    on<TodoListCheckTaskEvent>((event, emit) async {
      emit(TodoListLoadingState());
      var result = await updateCheckTask.call(event.taskModel);
      if (result.isSuccess) {
        await getTask(emit);
      } else {
        emit(TodoListShowErrorMessageState(result.message));
      }
    });

    on<TodoListCheckSubTaskEvent>((event, emit) async {
      emit(TodoListLoadingState());
      var result = await updateCheckSubTask.call(event.taskModel);
      if (result.isSuccess) {
        await getTask(emit);
      } else {
        emit(TodoListShowErrorMessageState(result.message));
      }
    });

    on<TodoListAddTaskEvent>((event, emit) async {
      emit(TodoListLoadingState());
      var result = await addTaskUseCase.call(event.taskModel);
      if (result.isSuccess) {
        await getTask(emit);
      } else {
        emit(TodoListShowErrorMessageState(result.message));
      }
    });

    on<TodoListAddSubTaskEvent>((event, emit) async {
      emit(TodoListLoadingState());
      var result = await addSubTaskUseCase.call(event.taskModel);
      if (result.isSuccess) {
        await getTask(emit);
      } else {
        emit(TodoListShowErrorMessageState(result.message));
      }
    });

    on<TodoListUpdateTaskEvent>((event, emit) async {
      emit(TodoListLoadingState());
      var result = await updateDataTaskUseCase.call(event.taskModel);
      if (result.isSuccess) {
        await getTask(emit);
      } else {
        emit(TodoListShowErrorMessageState(result.message));
      }
    });

    on<TodoListUpdateSubTaskEvent>((event, emit) async {
      emit(TodoListLoadingState());
      var result = await updateDataSubTaskUseCase.call(event.taskModel);
      if (result.isSuccess) {
        await getOnGoingTask(emit);
      } else {
        emit(TodoListShowErrorMessageState(result.message));
      }
    });

    on<TodoListDeleteTaskEvent>((event, emit) async {
      emit(TodoListLoadingState());
      var result = await deleteDataTaskUseCase.call(event.taskModel);
      if (result.isSuccess) {
        await getTask(emit);
      } else {
        emit(TodoListShowErrorMessageState(result.message));
      }
    });

    on<TodoListDeleteSubTaskEvent>((event, emit) async {
      emit(TodoListLoadingState());
      var result = await deleteDataSubTaskUseCase.call(event.taskModel);
      if (result.isSuccess) {
        await getTask(emit);
      } else {
        emit(TodoListShowErrorMessageState(result.message));
      }
    });

    on<TodoListTabOnGoingTaskEvent>((event, emit) async {
      isTabOnGoingTask = true;
      isTabCompletedTask = false;

      emit(TodoListTabOnGoingTaskState());
      await getTask(emit);
    });

    on<TodoListTabCompleteTaskEvent>((event, emit) async {
      isTabOnGoingTask = false;
      isTabCompletedTask = true;

      emit(TodoListTabCompletedTaskState());
      await getTask(emit);
    });
  }

  Future<void> getTask(Emitter<TodoListState> emit) async {
    emit(TodoListLoadingState());
    if (isTabOnGoingTask) {
      await getOnGoingTask(emit);
    } else {
      await getCompletedTask(emit);
    }
  }

  Future<void> getOnGoingTask(Emitter<TodoListState> emit) async {
    var result = await getAllOnGoingTask.call();
    if (result.isSuccess) {
      emit(TodoListGetOnGoingTaskCompletedState(result.data!));
    } else {
      emit(TodoListShowErrorMessageState(result.message));
    }
  }

  Future<void> getCompletedTask(Emitter<TodoListState> emit) async {
    var result = await getAllCompletedTask.call();
    if (result.isSuccess) {
      emit(TodoListGetOnGoingTaskCompletedState(result.data!));
    } else {
      emit(TodoListShowErrorMessageState(result.message));
    }
  }
}
