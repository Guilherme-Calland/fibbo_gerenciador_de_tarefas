import 'package:gerenciador_de_tarefas/features/tasks/data/dto/response/task_dto.dart';

class UpdateTaskRequestDTO{
  final int index;
  final TaskDTO task;

  UpdateTaskRequestDTO({required this.index, required this.task});

}