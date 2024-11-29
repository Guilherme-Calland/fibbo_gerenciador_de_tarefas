import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/core/usecase/usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/i_local_task_repository.dart';

class DeleteLocalTaskUsecase extends Usecase<bool, int>{
  final ILocalTaskRepository repository;

  DeleteLocalTaskUsecase(this.repository);

  @override
  Future<Either<Exception, bool>> call(int params) async{
    return await repository.deleteTask(params);
  }

}