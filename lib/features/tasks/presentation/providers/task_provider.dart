import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/dto/request/task_request_dto.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/get_sample_tasks_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_count_provider.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_scroll_provider.dart';
import 'package:provider/provider.dart';

class TaskProvider extends ChangeNotifier{
  final GetSampleTasksUsecase _getSampleTasksUsecase;
  TaskProvider({required GetSampleTasksUsecase getSampleTasksUsecase})
    : _getSampleTasksUsecase = getSampleTasksUsecase;

  bool _loading = true;
  bool get loading => _loading;

  bool _error = false;
  bool get error => _error;

  final List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  void _updateWidgetOnScreen(){
    notifyListeners();
  }

  int _currentPage = 1;
  int get currentPage => _currentPage;

  Future<bool> _getSampleTasks({
    required BuildContext context,
  }) async {
    final params = TaskPageRequestDTO(pageNumber: currentPage, pageSize: 10);
    final result = await _getSampleTasksUsecase(params);
    bool isLastPage = false;
    result.fold(
      (error) {
        debugPrint('$error');
        _error = true;
      },
      (taskPageResult) {
        _currentPage++;
        int completedTaskCount = 0;
        for (var task in taskPageResult.tasks) {
          _tasks.add(task);
          if (task.completed) {
            completedTaskCount++;
          }
        }

        context.read<TaskCountProvider>().onTasksLoad(
          taskCount: _tasks.length,
          completedTaskCount: completedTaskCount,
        );
        isLastPage = taskPageResult.isLastPage;
      },
    );

    return isLastPage;
  }

  deleteTask({required BuildContext context,required TaskModel task}) {
    _tasks.remove(task);
    context.read<TaskCountProvider>().onTaskDelete(task);

    //fibbo
    _updateWidgetOnScreen();

    context.read<TaskScrollProvider>().checkScrollExtent(context);
  }

  updateTask({
    required BuildContext context,
    required TaskModel task,
  }) {
    int index = _tasks.indexWhere((t)=> t.id == task.id);
    _tasks[index] = task.copyWith(completed: !_tasks[index].completed);
    context.read<TaskCountProvider>().onCompleteTaskToggle(_tasks[index]);
  }

  Future<bool> fetchNewTaskPage(BuildContext context) async{
    _error = false;
    bool isLastPage = await _getSampleTasks(context: context);
    _updateWidgetOnScreen();
    return isLastPage;
  }

  Future<void> getFirstSamplePage(BuildContext context) async {
    await _getSampleTasks(context: context);
    _loading = false;
    _updateWidgetOnScreen();
  }
}