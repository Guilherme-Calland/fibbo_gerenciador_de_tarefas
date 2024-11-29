import 'package:gerenciador_de_tarefas/core/hive/task_hive_manager.dart';
import 'package:gerenciador_de_tarefas/core/network/api_client.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/datasources/implementation/task_datasource.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/implementation/local_task_repository.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/implementation/task_repository.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/delete_all_local_tasks_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/delete_local_task_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/get_local_task_page_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/get_sample_tasks_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/save_local_task_page_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/save_local_task_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/create_task_provider.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider{
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<TaskProvider>(create: (_){
      final apiClient = ApiClient.getInstance();
      final taskDatasource = TaskDatasource.getInstance(apiClient);
      final taskRepository = TaskRepository.getInstance(taskDatasource);

      final localDatasource = TaskHiveManager.getInstance();
      final localTaskRepository = LocalTaskRepository(localDatasource);

      return TaskProvider(
        getSampleTasksUsecase: GetSampleTasksUsecase(taskRepository),
        saveLocalTaskPageUsecase: SaveLocalTaskPageUsecase(localTaskRepository),
        getLocalTaskPageUsecase: GetLocalTaskPageUsecase(localTaskRepository),
        deleteAllLocalTasksUsecase: DeleteAllLocalTasksUsecase(localTaskRepository),
        deleteLocalTaskUsecase: DeleteLocalTaskUsecase(localTaskRepository)
      );

    }),
    ChangeNotifierProvider<CreateTaskProvider>(create: (_){
      final localDatasource = TaskHiveManager.getInstance();
      final localTaskRepository = LocalTaskRepository(localDatasource);
      return CreateTaskProvider(
        saveLocalTaskUsecase: SaveLocalTaskUsecase(localTaskRepository)
      );
    }),
  ];
}