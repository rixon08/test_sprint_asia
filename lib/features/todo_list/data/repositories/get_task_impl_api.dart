import 'package:get_it/get_it.dart';
import 'package:test_sprint_asia/core/network/api_response.dart';
import 'package:test_sprint_asia/core/network/dio_network.dart';
import 'package:test_sprint_asia/core/utils/convert/date_time_to_string_convert.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/sub_task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/repositories/abstract_todo_list_api.dart';

class GetTaskImplApi extends AbstractTodoListApi {

  final DioNetwork dioNetwork = GetIt.instance<DioNetwork>();

  @override
  Future<ApiResponse<List<TaskModel>?>> getDataCompletedTask() async {
    return await dioNetwork.dioGet("/taskcompleted",(json) {
      if (json is List) {
        return TaskModel.fromJsonList(json);
      } else {
        return null;
      }
    }, {});
  }

  @override
  Future<ApiResponse<List<TaskModel>?>> getDataOnGoingTask() async {
    return await dioNetwork.dioGet("/taskongoing",(json) {
      if (json is List) {
        return TaskModel.fromJsonList(json);
      } else {
        return null;
      }
    }, {});
  }


  @override
  Future<ApiResponse<bool>> addDataTask(TaskModel task) async {
    return await dioNetwork.dioPost("/task",(json) {
      return true;
    }, {
      "title": task.title,
      "deadline": task.deadline != null ? convertDateTimeToStringForDB(task.deadline!) : null
    });
  }

  @override
  Future<ApiResponse<bool>> addDataSubTask(SubTaskModel task) async {
    return await dioNetwork.dioPost("/subtask",(json) {
      return true;
    }, {
      "title": task.title,
      "id_master": task.idMaster
    });
  }

  @override
  Future<ApiResponse<bool>> deleteDataTask(TaskModel task) async {
    return await dioNetwork.dioPost("/deletetask/${task.id}",(json) {
      return true;
    }, {});
  }

  @override
  Future<ApiResponse<bool>> deleteDataSubTask(SubTaskModel task) async {
    return await dioNetwork.dioPost("/deletesubtask/${task.id}",(json) {
      return true;
    }, {});
  }

  Future<ApiResponse<bool>> _updateDetailDataTask(TaskModel task) async {
    return await dioNetwork.dioPost("/updatetask/${task.id}",(json) {
      return true;
    }, {
      "title": task.title, 
      "deadline": task.deadline != null ? convertDateTimeToStringForDB(task.deadline!) : null, //optional
      "completed_date": task.completedDate != null ? convertDateTimeToStringForDB(task.completedDate!) : null, //optional
      "is_completed": task.isCompleted ? 1 : 0
    });
  }

  Future<ApiResponse<bool>> _updateDetailDataSubTask(SubTaskModel task) async {
    return await dioNetwork.dioPost("/updatesubtask/${task.id}",(json) {
      return true;
    }, {
      "title": task.title,
      "is_completed": task.isCompleted ? 1 : 0,
      "id_master": task.idMaster
    });
  }


  @override
  Future<ApiResponse<bool>> updateCheckTask(TaskModel task) async {
    task.setCompleteTask(!task.isCompleted);
    return await _updateDetailDataTask(task);
  }

  @override
  Future<ApiResponse<bool>> updateCheckSubTask(SubTaskModel subTask) async {
    subTask.isCompleted = !subTask.isCompleted;
    return await _updateDetailDataSubTask(subTask);
  }

  @override
  Future<ApiResponse<bool>> updateDataSubTask(SubTaskModel task) async {
    return await _updateDetailDataSubTask(task);
  }

  @override
  Future<ApiResponse<bool>> updateDataTask(TaskModel task) async {
    return await _updateDetailDataTask(task);
  }
}
