import 'package:gerenciador_de_tarefas/core/enums/priority.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveManager{
  static const taskModelTypeId = 1;
  static const taskPriorityTypeId = 2;

  static _registerAdapters(){
    Hive.registerAdapter(TaskModelAdapter());
    Hive.registerAdapter(TaskPriorityAdapter());
  }

  static Future<void> initHive() async{
    await Hive.initFlutter();
    _registerAdapters();
  }
}