import 'package:test_sprint_asia/core/network/api_response.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';

abstract class AbstractTodoListApi {

  Future<ApiResponse<List<TaskModel>?>> getDataOnGoingTask(DateTime date);

  Future<ApiResponse<List<TaskModel>?>> getDataCompletedTask(DateTime date);

  Future<ApiResponse<bool>> updateCheckTask(TaskModel task);

  Future<ApiResponse<bool>> updateCheckSubTask(TaskModel task);

  Future<ApiResponse<bool>> addDataTask(TaskModel task);

  Future<ApiResponse<bool>> addDataSubTask(TaskModel task);

  Future<ApiResponse<bool>> updateDataTask(TaskModel task);

  Future<ApiResponse<bool>> updateDataSubTask(TaskModel task);

  Future<ApiResponse<bool>> deleteDataTask(TaskModel task);

  Future<ApiResponse<bool>> deleteDataSubTask(TaskModel task);

}