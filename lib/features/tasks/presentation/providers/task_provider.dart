import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/get_sample_tasks_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_count_provider.dart';
import 'package:gerenciador_de_tarefas/main.dart';
import 'package:provider/provider.dart';

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

  Future<void> getSampleTasks(BuildContext context) async {
    final result = await _getSampleTasksUsecase();
    result.fold(
      (error) {
        debugPrint('$error');
        _error = true;
      },
      (tasksResult) {
        int completedTaskCount = 0;
        for (var task in tasksResult) {
          _tasks.add(task);
          if (task.completed) {
            completedTaskCount++;
          }
        }

        context.read<TaskCountProvider>().onTasksLoad(
          taskCount: _tasks.length,
          completedTaskCount: completedTaskCount,
        );
      },
    );
  }

  deleteTask({required BuildContext context,required TaskModel task}) {
    _tasks.remove(task);
    context.read<TaskCountProvider>().onTaskDelete(task);
  }

  toggleCompleted(TaskModel task){
    for(var t in _tasks){
      if(task.id == t.id){
        task = task.copyWith(completed: !t.completed);
      }
    }
  }
}