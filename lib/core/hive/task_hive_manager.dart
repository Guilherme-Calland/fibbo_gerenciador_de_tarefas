import 'package:gerenciador_de_tarefas/features/tasks/data/dto/request/task_request_dto.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskHiveManager{
  TaskHiveManager._();

  static TaskHiveManager? _instance;
  static TaskHiveManager getInstance(){
    _instance ??= TaskHiveManager._();
    return _instance!;
  }

  static Box<TaskModel>? _taskBox;

  static Future<Box<TaskModel>> _initBox() async {
    _taskBox ??= await Hive.openBox('tasks');
    return Future.value(_taskBox);
  }

  Future<bool> saveTask(TaskModel params) async {
    try{
      final box = await _initBox();
      await box.put('${params.id}', params);
      return true;
    }catch(e){
      throw Exception('$e');
    }
  }

  Future<bool> saveTaskPage(List<TaskModel> params) async {
    try{
      final box = await _initBox();
      for(var task in params){
        await box.put('${task.id}', task);
      }
      return true;
    }catch(e){
      throw Exception(e);
    }
  }

  Future<List<TaskModel>> getTaskPage(TaskPageRequestDTO params) async {
    try{
      final box = await _initBox();
      int lastTaskIndex = (params.pageNumber - 1) * params.pageSize;
      List<TaskModel> tasks = [];
      for(int i = 0; i < params.pageSize; i++){
        final task = box.getAt(lastTaskIndex + i);
        if(task == null) break;
        tasks.add(task);
      }
      return tasks;
    }catch(e){
      throw Exception(e);
    }
  }

  Future<bool> deleteAllTasks()async{
    try{
      final box = await _initBox();
      await box.clear();
      return true;
    }catch(e){
      throw Exception(e);
    }
  }
}