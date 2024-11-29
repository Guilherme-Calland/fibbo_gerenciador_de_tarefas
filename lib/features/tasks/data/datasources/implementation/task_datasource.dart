import 'package:gerenciador_de_tarefas/core/network/api_client.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/adapters/task_adapter.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/datasources/i_task_datasource.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/dto/task_dto.dart';

class TaskDatasource implements ITaskDatasource{
  TaskDatasource._(this.apiClient);
  static TaskDatasource? _instance;

  final ApiClient apiClient;

  static TaskDatasource getInstance(ApiClient apiClient){
    _instance ??= TaskDatasource._(apiClient);
    return _instance!;
  }

  @override
  Future<List<TaskDTO>> getSampleTasks() async {
    const String url = 'https://dummyjson.com/todos?limit=30';
    final response = await apiClient.get(url);
    bool success = response.statusCode == 200;
    if(success){

      final list = (response.data!["todos"] as List).map((json){
          return TaskAdapter.fromJson(json);
        }).toList();
      return list;
    }else{
      throw Exception("Error from server, response: ${response.data}");
    }
  }
}