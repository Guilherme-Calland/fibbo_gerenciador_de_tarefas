import 'package:flutter/foundation.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';

class TaskCountProvider extends ChangeNotifier{
  int _taskCount = 0;
  int get taskCount => _taskCount;

  int _completedTaskCount = 0;

  int get completedTaskCount => _completedTaskCount;

  void onTaskDelete(TaskModel task){
    _taskCount--;
    if(task.completed){
      _completedTaskCount--;
    }
    _updateScreen();
  }

  void _updateScreen(){
    notifyListeners();
  }

  void onTasksLoad({required int taskCount, required int completedTaskCount}) {
    _taskCount = taskCount;
    _completedTaskCount = completedTaskCount;
    _updateScreen();
  }

  void onCompleteTaskToggle(TaskModel task) {
    if(task.completed){
      _completedTaskCount++;
    }else{
      _completedTaskCount--;
    }
    _updateScreen();
  }
}