import 'package:flutter/material.dart';
import 'package:test_sprint_asia/core/utils/injection.dart';
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
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: TodoListPage(),
    );
  }
}