import 'package:test_sprint_asia/core/network/api_response.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/sub_task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/repositories/abstract_todo_list_api.dart';

class GetTaskImplApi extends AbstractTodoListApi {
  List<TaskModel> tasks = [
    TaskModel(id: "1", date: DateTime.now(), title: "Buy groceries", subTasks: [
      SubTaskModel(id: "2", title: "Milk", idMaster: "1"),
      SubTaskModel(id: "3", title: "Bread", idMaster: "1"),
      SubTaskModel(id: "4", title: "Eggs", idMaster: "1"),
    ]),
    TaskModel(id: "5", date: DateTime.now(), title: "Workout"),
    TaskModel(id: "6", date: DateTime.now(), title: "Prepare presentation"),
    TaskModel(id: "7", date: DateTime.now(), title: "Learn Flutter", subTasks: [
      SubTaskModel(id: "8", title: "Widgets", idMaster: "7"),
      SubTaskModel(
          id: "9",
          title: "State Management",
          idMaster: "7"),
      SubTaskModel(
          id: "10", title: "Navigation", idMaster: "7"),
    ])
  ];

  @override
  Future<ApiResponse<List<TaskModel>?>> getDataCompletedTask(
      DateTime date) async {
    return ApiResponse(status: true, message: "success", data: tasks);
  }

  @override
  Future<ApiResponse<List<TaskModel>?>> getDataOnGoingTask(
      DateTime date) async {
    return ApiResponse(
        status: true,
        message: "success",
        data: tasks
            .where((e) => DateTime(date.year, date.month, date.day).isAtSameMomentAs(
                DateTime(e.date.year, e.date.month, e.date.day)))
            .toList());
  }

  @override
  Future<ApiResponse<bool>> updateCheckTask(TaskModel task) async {
    tasks = tasks.map((e) {
      if (e.id == task.id) {
        task.isCompleted = !task.isCompleted;
        if (task.subTasks != null && task.subTasks!.isNotEmpty) {
          task.subTasks = task.subTasks!.map((st) {
            st.isCompleted = task.isCompleted;
            return st;
          }).toList();
        }
        return task;
      } else {
        return e;
      }
    }).toList();
    return ApiResponse(status: true, message: "success", data: true);
  }

  @override
  Future<ApiResponse<bool>> addDataSubTask(SubTaskModel task) async {
    tasks = tasks.map((e) {
      if (e.id == task.idMaster) {
        if (e.subTasks == null) {
          e.subTasks = [task];
        } else {
          e.subTasks!.add(task);
        }
        return e;
      } else {
        return e;
      }
    }).toList();
    return ApiResponse(status: true, message: "success", data: true);
  }

  @override
  Future<ApiResponse<bool>> addDataTask(TaskModel task) async {
    tasks.add(task);
    return ApiResponse(status: true, message: "success", data: true);
  }

  @override
  Future<ApiResponse<bool>> deleteDataSubTask(SubTaskModel task) async {
    int indexMasterTask = tasks.indexWhere((e) => e.id == task.idMaster);
    int indexDeleted =
        tasks[indexMasterTask].subTasks!.indexWhere((e) => e.id == task.id);
    tasks[indexMasterTask].subTasks!.removeAt(indexDeleted);
    return ApiResponse(status: true, message: "success", data: true);
  }

  @override
  Future<ApiResponse<bool>> deleteDataTask(TaskModel task) async {
    int indexDeleted = tasks.indexWhere((e) => e.id == task.id);
    tasks.removeAt(indexDeleted);
    return ApiResponse(status: true, message: "success", data: true);
  }

  @override
  Future<ApiResponse<bool>> updateCheckSubTask(SubTaskModel task) async {
    tasks = tasks.map((e) {
      if (e.id == task.idMaster &&
          e.subTasks != null &&
          e.subTasks!.isNotEmpty) {
        int countIsCompleted = 0;
        e.subTasks = e.subTasks!.map((st) {
          if (st.id == task.id) {
            task.isCompleted = !task.isCompleted;
            countIsCompleted =
                task.isCompleted ? countIsCompleted + 1 : countIsCompleted;
            return task;
          } else {
            countIsCompleted =
                st.isCompleted ? countIsCompleted + 1 : countIsCompleted;
            return st;
          }
        }).toList();
        if (countIsCompleted == e.subTasks!.length) {
          e.isCompleted = true;
        } else {
          e.isCompleted = false;
        }
        return e;
      } else {
        return e;
      }
    }).toList();
    return ApiResponse(status: true, message: "success", data: true);
  }

  @override
  Future<ApiResponse<bool>> updateDataSubTask(SubTaskModel task) async {
    tasks = tasks.map((e) {
      if (e.id == task.idMaster &&
          e.subTasks != null &&
          e.subTasks!.isNotEmpty) {
        int countIsCompleted = 0;
        e.subTasks = e.subTasks!.map((st) {
          if (st.id == task.id) {
            countIsCompleted =
                task.isCompleted ? countIsCompleted + 1 : countIsCompleted;
            return task;
          } else {
            countIsCompleted =
                st.isCompleted ? countIsCompleted + 1 : countIsCompleted;
            return st;
          }
        }).toList();
        if (countIsCompleted == e.subTasks!.length) {
          e.isCompleted = true;
        } else {
          e.isCompleted = false;
        }
        return e;
      } else {
        return e;
      }
    }).toList();
    return ApiResponse(status: true, message: "success", data: true);
  }

  @override
  Future<ApiResponse<bool>> updateDataTask(TaskModel task) async {
    tasks = tasks.map((e) {
      if (e.id == task.id) {
        return task;
      } else {
        return e;
      }
    }).toList();
    return ApiResponse(status: true, message: "success", data: true);
  }
}
