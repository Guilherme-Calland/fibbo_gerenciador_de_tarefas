import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/adapters/task_adapter.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/datasources/i_task_datasource.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
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
  Future<Either<Exception, List<TaskModel>>> getSampleTasks() async{
    try{
      final response = await datasource.getSampleTasks();
      final list = response.map((dto) => TaskAdapter.fromDTO(dto)).toList();
      return Right(list);
    }catch(e){
      return Left(Exception('Repository Exception: $e'));
    }
  }
}