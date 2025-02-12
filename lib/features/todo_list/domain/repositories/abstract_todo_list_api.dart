import 'package:test_sprint_asia/core/network/api_response.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/sub_task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';

abstract class AbstractTodoListApi {

  Future<ApiResponse<List<TaskModel>?>> getDataOnGoingTask();

  Future<ApiResponse<List<TaskModel>?>> getDataCompletedTask();

  Future<ApiResponse<bool>> updateCheckTask(TaskModel task);

  Future<ApiResponse<bool>> updateCheckSubTask(SubTaskModel task);

  Future<ApiResponse<bool>> addDataTask(TaskModel task);

  Future<ApiResponse<bool>> addDataSubTask(SubTaskModel task);

  Future<ApiResponse<bool>> updateDataTask(TaskModel task);

  Future<ApiResponse<bool>> updateDataSubTask(SubTaskModel task);

  Future<ApiResponse<bool>> deleteDataTask(TaskModel task);

  Future<ApiResponse<bool>> deleteDataSubTask(SubTaskModel task);

}