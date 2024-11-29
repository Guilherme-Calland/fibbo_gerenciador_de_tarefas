import 'package:gerenciador_de_tarefas/features/tasks/data/dto/response/task_dto.dart';

abstract class ITaskDatasource{
  Future<List<TaskDTO>> getSampleTasks();
}