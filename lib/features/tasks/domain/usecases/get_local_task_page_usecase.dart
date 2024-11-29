import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/core/usecase/usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/dto/request/task_request_dto.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/i_local_task_repository.dart';

class GetLocalTaskPageUsecase extends Usecase<List<TaskModel>, TaskPageRequestDTO>{
  final ILocalTaskRepository repository;

  GetLocalTaskPageUsecase(this.repository);

  @override
  Future<Either<Exception, List<TaskModel>>> call(TaskPageRequestDTO params) async{
    return repository.getTaskPage(params);
  }
}