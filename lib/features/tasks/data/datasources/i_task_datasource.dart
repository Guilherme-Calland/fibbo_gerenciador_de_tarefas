import 'package:gerenciador_de_tarefas/features/tasks/data/dto/task_response_dto.dart';

abstract class ITaskDatasource{
  Future<List<TaskResponseDTO>> getSampleTasks();
}