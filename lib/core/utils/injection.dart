
import 'package:get_it/get_it.dart';
import 'package:test_sprint_asia/core/network/dio_network.dart';
import 'package:test_sprint_asia/features/todo_list/todo_list_injection.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  initDioInjections();
  initTodoListInjections();
}

initDioInjections() async {
  sl.registerSingleton<DioNetwork>(DioNetwork());
}