import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_sprint_asia/core/network/utils/convert_date_time_to_string.dart';
import 'package:test_sprint_asia/core/network/utils/device_id_generator.dart';
import 'package:test_sprint_asia/core/network/utils/injection.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/sub_task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/add_sub_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/add_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/delete_data_sub_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/delete_data_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/get_all_completed_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/get_all_on_going_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_check_sub_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_check_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_data_sub_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_data_task_usecase.dart';
import 'package:test_sprint_asia/features/todo_list/presentation/bloc/todo_list_bloc.dart';
import 'package:test_sprint_asia/features/todo_list/presentation/enums/dialog_task_type_enum.dart';

class TodoListPage extends StatelessWidget {
  TodoListBloc _bloc = TodoListBloc(
    getAllOnGoingTask: sl<GetAllOnGoingTaskUseCase>(),
    getAllCompletedTask: sl<GetAllCompletedTaskUseCase>(),
    updateCheckTask: sl<UpdateCheckTaskUseCase>(),
    updateCheckSubTask: sl<UpdateCheckSubTaskUseCase>(),
    addTaskUseCase: sl<AddTaskUseCase>(),
    addSubTaskUseCase: sl<AddSubTaskUseCase>(),
    updateDataTaskUseCase: sl<UpdateDataTaskUseCase>(),
    updateDataSubTaskUseCase: sl<UpdateDataSubTaskUseCase>(),
    deleteDataTaskUseCase: sl<DeleteDataTaskUseCase>(),
    deleteDataSubTaskUseCase: sl<DeleteDataSubTaskUseCase>(),
  )..add(TodoListGetOnGoingTaskEvent());

  List<TaskModel> tasksOnGoing = [];

  bool isTabCompletedTask = false;
  bool isTabOnGoingTask = true;

  TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo list"),
          actions: [
            TextButton(
                onPressed: () {
                  _showAddEditTaskDialog(context, DialogTaskType.add);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        body: BlocConsumer<TodoListBloc, TodoListState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is TodoListGetOnGoingTaskCompletedState) {
              tasksOnGoing.clear();
              tasksOnGoing.addAll(state.listTaskModel);
            } else if (state is TodoListTabOnGoingTaskState) {
              isTabCompletedTask = false;
              isTabOnGoingTask = true;
            } else if (state is TodoListTabCompletedTaskState) {
              isTabCompletedTask = true;
              isTabOnGoingTask = false;
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: buttonTab(
                            isActive: isTabOnGoingTask,
                            title: "On Going Task",
                            onPressed: () {
                              _bloc.add(TodoListTabOnGoingTaskEvent());
                            })),
                    Expanded(
                        child: buttonTab(
                            isActive: isTabCompletedTask,
                            title: "Completed Task",
                            onPressed: () {
                              _bloc.add(TodoListTabCompleteTaskEvent());
                            })),
                  ],
                ),
                Container(
                  height: 0.3,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView(
                    children: tasksOnGoing.map((task) {
                      if (task.subTasks != null && task.subTasks!.isNotEmpty) {
                        return GestureDetector(
                          onLongPress: () {
                            _showBottomSheet(context, task: task);
                          },
                          child: ExpansionTile(
                            title: customCheckBoxWidget(task),
                            children: task.subTasks!.map((subTask) {
                              return ListTile(
                                onLongPress: () {
                                  _showBottomSheet(context, subTask: subTask);
                                },
                                dense: false,
                                leading: Checkbox(
                                    value: subTask.isCompleted,
                                    onChanged: (value) => _bloc.add(
                                        TodoListCheckSubTaskEvent(subTask))),
                                title: Text(subTask.title),
                              );
                            }).toList(),
                          ),
                        );
                      } else {
                        return Material(
                          child: InkWell(
                            onLongPress: () {
                              _showBottomSheet(context, task: task);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: customCheckBoxWidget(task),
                            ),
                          ),
                        );
                      }
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buttonTab(
      {required String title,
      required bool isActive,
      required VoidCallback onPressed}) {
    return SizedBox(
      height: 50,
      child: Material(
        color: isActive ? Colors.blue : Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isActive ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget customCheckBoxWidget(TaskModel task) {
    return Row(
      children: [
        Checkbox(
          value: task.isCompleted,
          onChanged: (value) => {_bloc.add(TodoListCheckTaskEvent(task))},
        ),
        Expanded(
          child: task.deadline == null
              ? Text(
                  "${task.title}${task.subTasks != null && task.subTasks!.isNotEmpty ? " (${task.precentageCompletedSubTask}%)" : ""}",
                  style: TextStyle(fontSize: 16))
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${task.title}${task.subTasks != null && task.subTasks!.isNotEmpty ? " (${task.precentageCompletedSubTask}%)" : ""}",
                        style: TextStyle(fontSize: 16)),
                    Text(
                      "Deadline: ${convertDateTimeToString(task.deadline!)} ${DateTime.now().isAfter(task.deadline!) && (task.completedDate == null || (task.completedDate != null && task.completedDate!.isAfter(task.deadline!))) ? "(Due)" : ""}",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
        )
      ],
    );
  }

  void _showAddEditTaskDialog(BuildContext context, DialogTaskType type,
      {TaskModel? task}) {
    TextEditingController controllerTaskName = TextEditingController();
    TextEditingController deadlineDateTimeController = TextEditingController();

    DateTime? selectedDeadlineDateTime = null;

    if (task != null && type == DialogTaskType.edit) {
      controllerTaskName.text = task.title;
      selectedDeadlineDateTime = task.deadline;
      if (task.deadline != null) {
        deadlineDateTimeController.text =
            convertDateTimeToString(task.deadline!);
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type == DialogTaskType.add ? "Add Task" : "Edit Task",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controllerTaskName,
                  decoration: InputDecoration(
                    labelText: "Task Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: deadlineDateTimeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Deadline",
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    DateTime? resultDate = await _selectDate(
                        context, selectedDeadlineDateTime ?? DateTime.now());
                    if (resultDate != null) {
                      TimeOfDay? resultTime = await _selectTime(
                          context,
                          TimeOfDay.fromDateTime(
                              selectedDeadlineDateTime ?? resultDate));
                      if (resultTime != null) {
                        selectedDeadlineDateTime = DateTime(
                            resultDate.year,
                            resultDate.month,
                            resultDate.day,
                            resultTime.hour,
                            resultTime.minute);
                        deadlineDateTimeController.text =
                            convertDateTimeToString(selectedDeadlineDateTime!);
                      }
                    }
                  },
                ),
                // const SizedBox(height: 20),
                // TextField(
                //     controller: timeController,
                //     readOnly: true,
                //     decoration: InputDecoration(
                //       labelText: "Select Deadline",
                //       suffixIcon: Icon(Icons.calendar_today),
                //       border: OutlineInputBorder(),
                //     ),
                //     onTap: () async {
                //       var result = await _selectTime(context, selectedTime);
                //       if (result != null) {
                //         selectedTime = result;
                //         timeController.text = convertTimeOfDayToString(result);
                //       }
                //     }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          if (type == DialogTaskType.add) {
                            _bloc.add(TodoListAddTaskEvent(TaskModel(
                                id: DeviceIdGenerator.generate(),
                                title: controllerTaskName.text,
                                deadline: selectedDeadlineDateTime)));
                          } else {
                            _bloc.add(TodoListUpdateTaskEvent(TaskModel(
                                id: task!.id,
                                title: controllerTaskName.text,
                                deadline: selectedDeadlineDateTime,
                                isCompleted: task.isCompleted,
                                subTasks: task.subTasks)));
                          }
                          Navigator.of(context).pop();
                        },
                        child:
                            Text(type == DialogTaskType.add ? "Add" : "Edit")),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddEditSubTaskDialog(
      BuildContext context, DialogTaskType type, String idMaster,
      {SubTaskModel? subTask}) {
    TextEditingController controllerTaskName = TextEditingController();

    if (subTask != null && type == DialogTaskType.edit) {
      controllerTaskName.text = subTask.title;
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type == DialogTaskType.add ? "Add Sub Task" : "Edit Sub Task",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controllerTaskName,
                  decoration: InputDecoration(
                    labelText: "Task Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          if (type == DialogTaskType.add) {
                            _bloc.add(TodoListAddSubTaskEvent(SubTaskModel(
                                id: DeviceIdGenerator.generate(),
                                title: controllerTaskName.text,
                                idMaster: idMaster)));
                          } else {
                            _bloc.add(TodoListUpdateSubTaskEvent(SubTaskModel(
                                id: subTask!.id,
                                title: controllerTaskName.text,
                                idMaster: idMaster)));
                          }
                          Navigator.of(context).pop();
                        },
                        child:
                            Text(type == DialogTaskType.add ? "Add" : "Edit")),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // String titleDate() {
  //   DateTime now = DateTime.now();
  //   DateTime today = DateTime(now.year, now.month, now.day);
  //   if (selectedDateTask.isAfter(today)) {
  //     return "TOMORROW";
  //   } else if (selectedDateTask.isBefore(today)) {
  //     return "YESTERDAY";
  //   } else {
  //     return "TODAY";
  //   }
  // }

  Future<DateTime?> _selectDate(BuildContext context, DateTime initial) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(initial.year - 100),
      lastDate: DateTime(initial.year + 100),
    );

    return pickedDate;
  }

  Future<TimeOfDay?> _selectTime(BuildContext context, TimeOfDay time) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

    return pickedTime;
  }

  void _showBottomSheet(BuildContext context,
      {TaskModel? task, SubTaskModel? subTask}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            if (task != null && isTabOnGoingTask)
              ListTile(
                leading: Icon(Icons.add),
                title: Text("Add Sub Task"),
                onTap: () {
                  Navigator.of(context).pop();
                  _showAddEditSubTaskDialog(
                      context, DialogTaskType.add, task.id);
                },
              ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit ${subTask != null ? "Sub " : ""}Task"),
              onTap: () {
                Navigator.of(context).pop();
                if (subTask != null) {
                  _showAddEditSubTaskDialog(
                      context, DialogTaskType.edit, subTask.idMaster,
                      subTask: subTask);
                } else {
                  _showAddEditTaskDialog(context, DialogTaskType.edit,
                      task: task);
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete Task"),
              onTap: () {
                if (task != null) {
                  _bloc.add(TodoListDeleteTaskEvent(task));
                } else {
                  _bloc.add(TodoListDeleteSubTaskEvent(subTask!));
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
