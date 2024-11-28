import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/adapters/task_adapter.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/datasources/i_task_datasource.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/dto/request/task_request_dto.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_page.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/i_task_repository.dart';

class TaskRepository implements ITaskRepository{
  TaskRepository._(this.datasource);
  static TaskRepository? _instance;
  static TaskRepository getInstance(ITaskDatasource datasource){
    _instance ??= TaskRepository._(datasource);
    return _instance!;
  }

  final ITaskDatasource datasource;

  @override
  Future<Either<Exception, TaskPage>> getSampleTasks(TaskPageRequestDTO request) async{
    try{
      final response = await datasource.getSampleTasks(request);
      final taskPage = TaskPage(
        tasks: response.tasks.map((dto) => TaskAdapter.fromDTO(dto)).toList(),
        isLastPage: response.isLastPage,
        total: response.total,
      );
      return Right(taskPage);
    }catch(e){
      return Left(Exception('Repository Exception: $e'));
    }
  }
}