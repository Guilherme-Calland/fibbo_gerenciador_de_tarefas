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

  void updateScreen(){
    notifyListeners();
  }

  Future<void> getSampleTasks()async{
    final result = await _getSampleTasksUsecase();
    result.fold((error){
      debugPrint('$error');
      _error = true;
    }, (tasksResult){
      _tasks.addAll(tasksResult);
    });
  }
}