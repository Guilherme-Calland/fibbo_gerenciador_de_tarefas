import 'package:dartz/dartz.dart';
import 'package:gerenciador_de_tarefas/core/hive/task_hive_manager.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/repositories/i_local_task_repository.dart';

class LocalTaskRepository implements ILocalTaskRepository{
  final TaskHiveManager datasource;

  LocalTaskRepository(this.datasource);

  @override
  Future<Either<Exception, int>> saveTask(TaskModel params) async{
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

  @override
  Future<Either<Exception, List<TaskModel>>> getTaskPage() async{
    try{
      final result = await datasource.getTaskPage();
      return Right(result);
    }catch(e){
      return Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, bool>> deleteAllTasks() async{
    try{
      final result = await datasource.deleteAllTasks();
      return Right(result);
    }catch(e){
      return Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, bool>> deleteTask(int params) async{
    try{
      final result = await datasource.deleteTask(params);
      return Right(result);
    }catch(e){
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, bool>> updateTask(TaskModel params)async {
    try{
      final result = await datasource.updateTask(params);
      return Right(result);
    }catch(e){
      return Left(Exception(e));
    }
  }

}