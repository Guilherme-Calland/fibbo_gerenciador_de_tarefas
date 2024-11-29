import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/core/usecase/usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/dto/request/task_request_dto.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_page.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/i_task_repository.dart';

class GetSampleTasksUsecase extends Usecase<TaskPage, TaskPageRequestDTO>{
  final ITaskRepository repository;
  GetSampleTasksUsecase(this.repository);

  @override
  Future<Either<Exception, TaskPage>> call(TaskPageRequestDTO params) async{
    return await repository.getSampleTasks(params);
  }
  
}