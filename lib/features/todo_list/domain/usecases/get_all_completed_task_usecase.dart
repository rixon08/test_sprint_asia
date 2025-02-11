import 'package:test_sprint_asia/core/network/api_response.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/repositories/abstract_todo_list_api.dart';

class GetAllCompletedTaskUseCase {

  final AbstractTodoListApi repository;

  GetAllCompletedTaskUseCase(this.repository);
  
  Future<ApiResponse<List<TaskModel>?>> call(DateTime date) async {
    return await repository.getDataCompletedTask(date);
  }

}