import 'package:gerenciador_de_tarefas/core/network/api_client.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/datasources/i_task_datasource.dart';

class TaskDatasource implements ITaskDatasource{
  TaskDatasource._(this.apiClient);
  static TaskDatasource? _instance;

  final ApiClient apiClient;

  static TaskDatasource getInstance(ApiClient apiClient){
    _instance ??= TaskDatasource._(apiClient);
    return _instance!;
  }

  @override
  Future<Map<String, dynamic>> getSampleTasks() {
    throw UnimplementedError();
  }

}