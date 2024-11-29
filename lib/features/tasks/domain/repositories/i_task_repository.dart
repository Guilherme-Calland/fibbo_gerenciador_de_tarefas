import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_page.dart';

abstract class ITaskRepository {
  Future<Either<Exception, TaskPage>> getSampleTasks();
}