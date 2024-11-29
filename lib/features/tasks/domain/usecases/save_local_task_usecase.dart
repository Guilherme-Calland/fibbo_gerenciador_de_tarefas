import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/core/usecase/usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/i_local_task_repository.dart';

class SaveLocalTaskUsecase extends Usecase<int, TaskModel>{
  final ILocalTaskRepository repository;
  SaveLocalTaskUsecase(this.repository);

  @override
  Future<Either<Exception, int>> call(TaskModel params) {
    return repository.saveTask(params);
  }
}