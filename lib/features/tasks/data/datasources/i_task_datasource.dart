import 'package:gerenciador_de_tarefas/features/tasks/data/dto/request/task_request_dto.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/dto/response/task_response_page_dto.dart';

abstract class ITaskDatasource{
  Future<TaskPageResponseDTO> getSampleTasks(TaskPageRequestDTO dto);
}