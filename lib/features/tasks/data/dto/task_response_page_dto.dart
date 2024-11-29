import 'package:gerenciador_de_tarefas/features/tasks/data/dto/task_response_dto.dart';

class TaskPageResponseDTO{
  final List<TaskResponseDTO> tasks;
  final int total;

  TaskPageResponseDTO({
    required this.tasks,
    required this.total
  });
}