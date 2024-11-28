import 'package:gerenciador_de_tarefas/core/network/api_client.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/datasources/implementation/task_datasource.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/implementation/task_repository.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/get_sample_tasks_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_count_provider.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_provider.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_scroll_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider{
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<TaskProvider>(create: (_){
      final apiClient = ApiClient.getInstance();
      final datasource = TaskDatasource.getInstance(apiClient);
      final repository = TaskRepository.getInstance(datasource);

      return TaskProvider(
        getSampleTasksUsecase: GetSampleTasksUsecase(repository)
      );

    }),
    ChangeNotifierProvider<TaskCountProvider>(create: (_){
      return TaskCountProvider();
    }),
    ChangeNotifierProvider<TaskScrollProvider>(create: (_){
      return TaskScrollProvider();
    })
  ];
}