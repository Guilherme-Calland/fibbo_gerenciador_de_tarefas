import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/core/usecase/usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/dto/request/update_task_request_dto.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/i_local_task_repository.dart';

class UpdateLocalTaskUsecase extends Usecase<bool, UpdateTaskRequestDTO>{
  final ILocalTaskRepository repository;
  UpdateLocalTaskUsecase(this.repository);

  @override
  Future<Either<Exception, bool>> call(UpdateTaskRequestDTO params) async {
    return await repository.updateTask(params);
  }
}