import 'package:flutter/material.dart';
import 'package:test_sprint_asia/core/network/utils/injection.dart';
import 'package:test_sprint_asia/features/todo_list/presentation/pages/todo_list_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initInjections();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: TodoListPage(),
    );
  }
}

class Task {
  String title;
  bool isCompleted;
  List<Task>? subTasks;

  Task({required this.title, this.isCompleted = false, this.subTasks});
}

class TodoListPage1 extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage1> {
  List<Task> tasks = [
    Task(title: "Buy groceries", subTasks: [
      Task(title: "Milk"),
      Task(title: "Bread"),
      Task(title: "Eggs"),
    ]),
    Task(title: "Workout"),
    Task(title: "Prepare presentation"),
    Task(title: "Learn Flutter", subTasks: [
      Task(title: "Widgets"),
      Task(title: "State Management"),
      Task(title: "Navigation"),
    ]),
  ];

  void toggleParent(Task task, bool? value) {
    setState(() {
      bool newValue = value ?? false;
      task.isCompleted = newValue;
      if (task.subTasks != null) {
        for (var subTask in task.subTasks!) {
          subTask.isCompleted = newValue;
        }
      }
    });
  }

  void toggleSubTask(Task parent, Task subTask, bool? value) {
    setState(() {
      subTask.isCompleted = value ?? false;
      if (parent.subTasks != null) {
        parent.isCompleted = parent.subTasks!.every((task) => task.isCompleted);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List")),
      body: ListView(
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
                    onChanged: (value) => toggleSubTask(task, subTask, value),
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
      ),
    );
  }
}