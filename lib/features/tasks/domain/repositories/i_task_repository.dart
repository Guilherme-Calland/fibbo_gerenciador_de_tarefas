import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';

abstract class ITaskRepository {
  Future<Either<Exception, List<TaskModel>>> getSampleTasks();
}