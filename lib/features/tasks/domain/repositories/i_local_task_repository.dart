import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';

abstract class ILocalTaskRepository{
  Future<Either<Exception, bool>> saveTask(TaskModel params);
  Future<Either<Exception, bool>> saveTaskPage(List<TaskModel> params);
  Future<Either<Exception, List<TaskModel>>> getTaskPage();
  Future<Either<Exception, bool>> deleteAllTasks();
  Future<Either<Exception, bool>> deleteTask(int params);
}