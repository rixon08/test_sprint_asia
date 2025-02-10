import 'package:test_sprint_asia/core/network/api_response.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/repositories/abstract_todo_list_api.dart';

class GetTaskImplApi extends AbstractTodoListApi{

  List<TaskModel> tasks = [
    TaskModel(id: "1", date: DateTime.now() ,title: "Buy groceries", subTasks: [
      TaskModel(id: "2", date: DateTime.now(), title: "Milk", idMaster: "1"),
      TaskModel(id: "3", date: DateTime.now(), title: "Bread", idMaster: "1"),
      TaskModel(id: "4", date: DateTime.now(),title: "Eggs", idMaster: "1"),
    ]),
    TaskModel(id: "5", date: DateTime.now(),title: "Workout"),
    TaskModel(id: "6", date: DateTime.now(),title: "Prepare presentation"),
    TaskModel(id: "7", date: DateTime.now(),title: "Learn Flutter", subTasks: [
      TaskModel(id: "8", date: DateTime.now(),title: "Widgets", idMaster: "7"),
      TaskModel(id: "9", date: DateTime.now(),title: "State Management", idMaster: "7"),
      TaskModel(id: "10", date: DateTime.now(),title: "Navigation", idMaster: "7"),
    ])];

  @override
  Future<ApiResponse<List<TaskModel>?>> getDataCompletedTask(DateTime date) async {
    return ApiResponse(status: true, message: "success", data: tasks);
  }

  @override
  Future<ApiResponse<List<TaskModel>?>> getDataOnGoingTask(DateTime date) async {
    return ApiResponse(status: true, message: "success", data: tasks);
  }
  
  @override
  Future<ApiResponse<bool>> updateCheckTask(TaskModel task) async {
    tasks = tasks.map((e) {
      if(e.id == task.id){
        task.isCompleted = !task.isCompleted;
        return task;
      }else{
        return e;
      }
    }).toList();
    return ApiResponse(status: true, message: "success", data: true);
  }
  
  @override
  Future<ApiResponse<bool>> updateCheckSubTask(TaskModel task) async {
    tasks = tasks.map((e) {
      if(e.id == task.id){
        task.isCompleted = !task.isCompleted;
        return task;
      }else{
        return e;
      }
    }).toList();
    return ApiResponse(status: true, message: "success", data: true);
  }
  
}