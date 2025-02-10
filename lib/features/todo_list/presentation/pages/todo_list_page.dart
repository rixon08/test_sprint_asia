import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_sprint_asia/core/network/utils/injection.dart';
import 'package:test_sprint_asia/features/todo_list/domain/models/task_model.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/get_all_completed_task.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/get_all_on_going_task.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_check_sub_task.dart';
import 'package:test_sprint_asia/features/todo_list/domain/usecases/update_check_task.dart';
import 'package:test_sprint_asia/features/todo_list/presentation/bloc/todo_list_bloc.dart';

class TodoListPage extends StatelessWidget {
  TodoListBloc _bloc = TodoListBloc(
      sl<GetAllOnGoingTask>(), sl<UpdateCheckTask>(), sl<UpdateCheckSubTask>())
    ..add(TodoListGetOnGoingTaskEvent());

  List<TaskModel> tasksOnGoing = [];

  TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        body: BlocConsumer<TodoListBloc, TodoListState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is TodoListGetOnGoingTaskCompletedState) {
              tasksOnGoing.clear();
              tasksOnGoing.addAll(state.listTaskModel);
            }
          },
          builder: (context, state) {
            return ListView(
              children: tasksOnGoing.map((task) {
                if (task.subTasks != null && task.subTasks!.isNotEmpty) {
                  return ExpansionTile(
                    title: Row(
                      children: [
                        Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) =>
                                _bloc.add(TodoListCheckTaskEvent(task))),
                        Expanded(child: Text(task.title)),
                      ],
                    ),
                    children: task.subTasks!.map((subTask) {
                      return ListTile(
                        dense: false,
                        leading: Checkbox(
                            value: subTask.isCompleted,
                            onChanged: (value) =>
                                _bloc.add(TodoListCheckSubTaskEvent(task))),
                        title: Text(subTask.title),
                      );
                    }).toList(),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) =>
                              {_bloc.add(TodoListCheckTaskEvent(task))},
                        ),
                        Expanded(child: Text(task.title)),
                      ],
                    ),
                  );

                  // ListTile(
                  //   leading: Checkbox(
                  //     value: task.isCompleted,
                  //     onChanged: (value) => setState(() {
                  //       task.isCompleted = value ?? false;
                  //     }),
                  //   ),
                  //   title: Text(task.title),
                  // );
                }
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
