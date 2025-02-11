import 'package:test_sprint_asia/core/network/api_response.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/repositories/abstract_todo_list_api.dart';

class AddTaskUseCase {
final AbstractTodoListApi repository;

  AddTaskUseCase(this.repository);
  
  Future<ApiResponse<bool>> call(TaskModel task) async {
    return await repository.addDataTask(task);
  }
}