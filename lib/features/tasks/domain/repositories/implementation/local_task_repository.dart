import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/core/hive/task_hive_manager.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/i_local_task_repository.dart';

class LocalTaskRepository implements ILocalTaskRepository{

  final TaskHiveManager datasource;

  LocalTaskRepository(this.datasource);

  @override
  Future<Either<Exception, bool>> saveTask(TaskModel params) async{
    try{
      final result = await datasource.saveTask(params);
      return Right(result);
    }catch(e){
      return Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, bool>> saveTaskPage(List<TaskModel> params) async{
    try{
      final result = await datasource.saveTaskPage(params);
      return Right(result);
    }catch(e){
      return Left(Exception(e));
    }
  }

}