import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/core/usecase/usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/i_local_task_repository.dart';

class DeleteAllLocalTasksUsecase extends Usecase<bool, NoParams>{
  final ILocalTaskRepository repository;

  DeleteAllLocalTasksUsecase(this.repository);

  @override
  Future<Either<Exception, bool>> call(NoParams params) async{
    return await repository.deleteAllTasks();
  }
}