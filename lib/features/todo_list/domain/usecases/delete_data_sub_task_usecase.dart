import 'package:test_sprint_asia/core/network/api_response.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/sub_task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/repositories/abstract_todo_list_api.dart';

class DeleteDataSubTaskUseCase {
  AbstractTodoListApi repositories;

  DeleteDataSubTaskUseCase(this.repositories);

  Future<ApiResponse<bool>> call(SubTaskModel task) async {
    return await repositories.deleteDataSubTask(task);
  }
}