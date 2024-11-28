import 'package:gerenciador_de_tarefas/features/tasks/data/dto/request/save_local_task_page_request.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_page/task_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskHiveManager{
  static Box<TaskPage>? _taskBox;

  static Future<Box<TaskPage>> _initBox() async {
    _taskBox ??= await Hive.openBox('tasks');
    return Future.value(_taskBox);
  }

  Future<bool> saveTaskPage(SaveLocalTaskPageRequest params) async {
    try{
      final box = await _initBox();
      await box.put('${params.pageNumber}', params.taskPage);
      return true;
    }catch(e){
      throw Exception('$e');
    }
  }
}