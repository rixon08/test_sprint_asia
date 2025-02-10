import 'package:test_sprint_asia/core/network/api_response.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';

abstract class AbstractTodoListApi {

  Future<ApiResponse<List<TaskModel>?>> getDataOnGoingTask(DateTime date);

  Future<ApiResponse<List<TaskModel>?>> getDataCompletedTask(DateTime date);

}