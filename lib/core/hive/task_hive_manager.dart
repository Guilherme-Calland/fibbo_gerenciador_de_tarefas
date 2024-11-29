import 'package:gerenciador_de_tarefas/features/tasks/data/adapters/task_adapter.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/dto/request/update_task_request_dto.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
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
    _taskBox ??= await Hive.openBox('task');
    return Future.value(_taskBox);
  }

  Future<bool> saveTask(TaskModel params) async {
    try{
      final box = await _initBox();
      await box.add(params);
      return true;
    }catch(e){
      throw Exception('$e');
    }
  }

  Future<bool> saveTaskPage(List<TaskModel> params) async {
    try{
      final box = await _initBox();
      await box.addAll(params);
      return true;
    }catch(e){
      throw Exception(e);
    }
  }

  Future<List<TaskModel>> getTaskPage() async {
    try{
      final box = await _initBox();
      return box.values.toList(growable: false);
    }catch(e){
      throw Exception(e);
    }
  }

  Future<bool> updateTask(UpdateTaskRequestDTO params)async{
    try{
      final box = await _initBox();
      final task = TaskAdapter.fromDTO(params.task);
      await box.putAt(params.index, task);
      return true;
    }catch(e){
      throw Exception(e);
    }
  }

  Future<bool> deleteTask(int index) async {
    try{
      final box = await _initBox();
      await box.deleteAt(index);
      return true;
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