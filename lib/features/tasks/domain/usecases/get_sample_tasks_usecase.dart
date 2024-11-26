import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/core/usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/implementation/task_repository.dart'; 

class GetSampleTasksUsecase extends Usecase<TaskModel, NoParams>{
  final TaskRepository repository;

  GetSampleTasksUsecase(this.repository);

  @override
  Future<Either<Exception, List<TaskModel>>> call(NoParams params) async{
    return await repository.getSampleTasks();
  }
  
}