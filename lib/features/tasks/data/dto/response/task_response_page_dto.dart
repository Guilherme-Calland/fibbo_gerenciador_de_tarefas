import 'package:gerenciador_de_tarefas/features/tasks/data/dto/response/task_response_dto.dart';

class TaskPageResponseDTO{
  final List<TaskResponseDTO> tasks;
  final bool isLastPage;

  TaskPageResponseDTO({
    required this.tasks,
    required this.isLastPage,
  });
}