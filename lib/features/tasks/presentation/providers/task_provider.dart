import 'package:flutter/foundation.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/get_sample_tasks_usecase.dart';

class TaskProvider extends ChangeNotifier{
  final GetSampleTasksUsecase _getSampleTasksUsecase;
  TaskProvider({required GetSampleTasksUsecase getSampleTasksUsecase})
    : _getSampleTasksUsecase = getSampleTasksUsecase;

  bool loading = true;

  bool _error = false;
  bool get error => _error;

  final List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  int _completedTaskCount = 0;
  int get completedTaskCount => _completedTaskCount;

  void updateScreen(){
    notifyListeners();
  }

  Future<void> getSampleTasks()async{
    final result = await _getSampleTasksUsecase();
    result.fold((error){
      debugPrint('$error');
      _error = true;
    }, (tasksResult){
      for (var task in tasksResult) {
        _tasks.add(task);        
        if(task.completed) _completedTaskCount++;
      }
    });
  }

  deleteTask(int id) {
    for(var task in _tasks){
      if(task.id == id){
        _tasks.remove(task);
        if(task.completed){
          _completedTaskCount--;
        }
      }
    }
    _tasks.removeWhere((task) => task.id == id);
  }

  toggleCompleted(TaskModel task){
    // for(var t in _tasks){
    //   if(task.id == t.id){
    //     task.completed = !t.completed;
    //   }
    // }
  }
}