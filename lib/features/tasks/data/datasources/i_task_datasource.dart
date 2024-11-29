import 'package:gerenciador_de_tarefas/features/tasks/data/dto/task_response_page_dto.dart';

abstract class ITaskDatasource{
  Future<TaskPageResponseDTO> getSampleTasks();
}