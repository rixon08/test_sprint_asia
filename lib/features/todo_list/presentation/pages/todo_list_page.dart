import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_sprint_asia/features/todo_list/presentation/bloc/todo_list_bloc.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoListBloc(),
      child: Scaffold(
        body: BlocBuilder<TodoListBloc, TodoListState>(
          builder: (context, state) {
            return ListView(
              children: tasks.map((task) {
                if (task.subTasks != null && task.subTasks!.isNotEmpty) {
                  return ExpansionTile(
                    title: Row(
                      children: [
                        Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) => toggleParent(task, value),
                        ),
                        Expanded(child: Text(task.title)),
                      ],
                    ),
                    children: task.subTasks!.map((subTask) {
                      return ListTile(
                        dense: false,
                        leading: Checkbox(
                          value: subTask.isCompleted,
                          onChanged: (value) =>
                              toggleSubTask(task, subTask, value),
                        ),
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
                          onChanged: (value) => setState(() {
                            task.isCompleted = value ?? false;
                          }),
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
