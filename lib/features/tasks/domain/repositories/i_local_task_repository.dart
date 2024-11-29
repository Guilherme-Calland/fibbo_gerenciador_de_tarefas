import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';

abstract class ILocalTaskRepository{
  Future<Either<Exception, bool>> saveTask(TaskModel params);
  Future<Either<Exception, bool>> saveTaskPage(List<TaskModel> params);
}