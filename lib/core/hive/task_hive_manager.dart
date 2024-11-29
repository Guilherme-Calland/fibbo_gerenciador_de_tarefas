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
    _taskBox ??= await Hive.openBox('task_hive');
    return Future.value(_taskBox);
  }

  Future<int> saveTask(TaskModel params) async {
    try{
      final box = await _initBox();
      final newTask = params.copyWith(id: box.length + 1);
      await box.put(newTask.id, newTask);
      return newTask.id!;
    }catch(e){
      throw Exception('$e');
    }
  }

  Future<bool> saveTaskPage(List<TaskModel> params) async {
    try{
      final box = await _initBox();
      for(var task in params){
        box.put(task.id, task);
      }
      return true;
    }catch(e){
      throw Exception(e);
    }
  }

  Future<List<TaskModel>> getTaskPage() async {
    try{
      final box = await _initBox();
      final List<TaskModel> list =  box.values.toList(growable: false);
      return list..sort((a, b) => a.id!.compareTo(b.id!));
    }catch(e){
      throw Exception(e);
    }
  }

  Future<bool> updateTask(TaskModel task)async{
    try{
      final box = await _initBox();
      await box.put(task.id!, task);
      return true;
    }catch(e){
      throw Exception(e);
    }
  }

  Future<bool> deleteTask(int id) async {
    try{
      final box = await _initBox();
      await box.delete(id);
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