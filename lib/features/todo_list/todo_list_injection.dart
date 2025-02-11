import 'package:test_sprint_asia/core/network/utils/injection.dart';
import 'package:test_sprint_asia/features/todo_list/data/repositories/get_task_impl_api.dart';
import 'package:test_sprint_asia/features/todo_list/domain/repositories/abstract_todo_list_api.dart';
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

initTodoListInjections() {
  sl.registerSingleton<AbstractTodoListApi>(GetTaskImplApi());
  sl.registerSingleton<GetAllOnGoingTaskUseCase>(GetAllOnGoingTaskUseCase(sl()));
  sl.registerSingleton<GetAllCompletedTaskUseCase>(GetAllCompletedTaskUseCase(sl()));
  sl.registerSingleton<UpdateCheckTaskUseCase>(UpdateCheckTaskUseCase(sl()));
  sl.registerSingleton<UpdateCheckSubTaskUseCase>(UpdateCheckSubTaskUseCase(sl()));
  sl.registerSingleton<AddTaskUseCase>(AddTaskUseCase(sl()));
  sl.registerSingleton<AddSubTaskUseCase>(AddSubTaskUseCase(sl()));
  sl.registerSingleton<UpdateDataTaskUseCase>(UpdateDataTaskUseCase(sl()));
  sl.registerSingleton<UpdateDataSubTaskUseCase>(UpdateDataSubTaskUseCase(sl()));
  sl.registerSingleton<DeleteDataTaskUseCase>(DeleteDataTaskUseCase(sl()));
  sl.registerSingleton<DeleteDataSubTaskUseCase>(DeleteDataSubTaskUseCase(sl()));
}