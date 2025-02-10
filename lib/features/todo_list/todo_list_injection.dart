import 'package:test_sprint_asia/core/network/utils/injection.dart';
import 'package:test_sprint_asia/features/todo_list/domain/repositories/abstract_todo_list_api.dart';

initLoginInjections() {
  sl.registerSingleton<AbstractTodoListApi>(LoginImplApi());
  sl.registerSingleton<AbstractLoginLocal>(LoginImplLocal());
  sl.registerSingleton<LoginUserUseCase>(LoginUserUseCase(sl()));
  sl.registerSingleton<SaveUnitIdUseCase>(SaveUnitIdUseCase(sl()));
  sl.registerSingleton<SaveUserIdUseCase>(SaveUserIdUseCase(sl()));
}