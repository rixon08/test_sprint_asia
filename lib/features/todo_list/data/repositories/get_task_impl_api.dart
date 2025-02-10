import 'package:test_sprint_asia/core/network/api_response.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/repositories/abstract_todo_list_api.dart';

class GetTaskImplApi extends AbstractTodoListApi{
  @override
  Future<ApiResponse<List<TaskModel>?>> getDataCompletedTask(DateTime date) {
    return 
  }

  @override
  Future<ApiResponse<List<TaskModel>?>> getDataOnGoingTask(DateTime date) {
    
  }
  
}