import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/core/usecase/usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/i_local_task_repository.dart';

class SaveLocalTaskPageUsecase extends Usecase<bool, List<TaskModel>>{
  final ILocalTaskRepository repository;
  SaveLocalTaskPageUsecase(this.repository);

  @override
  Future<Either<Exception, bool>> call(List<TaskModel> params) async {
    return await repository.saveTaskPage(params);
  }
}