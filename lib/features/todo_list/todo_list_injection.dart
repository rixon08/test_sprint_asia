import 'package:test_sprint_asia/core/network/utils/injection.dart';
import 'package:test_sprint_asia/features/todo_list/data/repositories/get_task_impl_api.dart';
import 'package:test_sprint_asia/features/todo_list/domain/repositories/abstract_todo_list_api.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/get_all_completed_task.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/get_all_on_going_task.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_check_sub_task.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_check_task.dart';

initTodoListInjections() {
  sl.registerSingleton<AbstractTodoListApi>(GetTaskImplApi());
  sl.registerSingleton<GetAllOnGoingTask>(GetAllOnGoingTask(sl()));
  sl.registerSingleton<GetAllCompletedTask>(GetAllCompletedTask(sl()));
  sl.registerSingleton<UpdateCheckTask>(UpdateCheckTask(sl()));
  sl.registerSingleton<UpdateCheckSubTask>(UpdateCheckSubTask(sl()));
}