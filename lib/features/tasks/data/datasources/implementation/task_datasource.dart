import 'package:gerenciador_de_tarefas/core/network/api_client.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/adapters/task_adapter.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/datasources/i_task_datasource.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/dto/task_response_page_dto.dart';

class TaskDatasource implements ITaskDatasource{
  TaskDatasource._(this.apiClient);
  static TaskDatasource? _instance;

  final ApiClient apiClient;

  static TaskDatasource getInstance(ApiClient apiClient){
    _instance ??= TaskDatasource._(apiClient);
    return _instance!;
  }

  @override
  Future<TaskPageResponseDTO> getSampleTasks() async {
    const String url = 'https://dummyjson.com/todos?limit=30';
    final response = await apiClient.get(url);
    bool success = response.statusCode == 200;
    if(success){

      return TaskPageResponseDTO(
        tasks: (response.data!["todos"] as List).map((json){
          return TaskAdapter.fromJson(json);
        }).toList(),
        total: response.data!["total"]
      );
    }else{
      throw Exception("Error from server, response: ${response.data}");
    }
  }
}