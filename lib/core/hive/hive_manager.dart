import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_page/task_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveManager{
  static const taskPageTypeId = 0;
  static const taskModelTypeId = 1;

  static _registerAdapters(){
    Hive.registerAdapter(TaskPageAdapter());
    Hive.registerAdapter(TaskModelAdapter());
  }

  static Future<void> initHive() async{
    await Hive.initFlutter();
    _registerAdapters();
  }
}