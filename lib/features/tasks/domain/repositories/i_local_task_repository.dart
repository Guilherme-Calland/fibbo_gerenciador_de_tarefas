import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';

abstract class ILocalTaskRepository{
  Future<Either<Exception, int>> saveTask(TaskModel params);
  Future<Either<Exception, bool>> saveTaskPage(List<TaskModel> params);
  Future<Either<Exception, List<TaskModel>>> getTaskPage();
  Future<Either<Exception, bool>> deleteAllTasks();
  Future<Either<Exception, bool>> deleteTask(int params);
  Future<Either<Exception, bool>> updateTask(TaskModel params);
}