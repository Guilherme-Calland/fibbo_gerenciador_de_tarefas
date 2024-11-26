import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/i_task_repository.dart';

class TaskRepository implements ITaskRepository{
  @override
  Future<Either<Exception, List<TaskModel>>> getSampleTasks() async{
    // TODO: implement getSampleTasks
    throw UnimplementedError();
  }
}