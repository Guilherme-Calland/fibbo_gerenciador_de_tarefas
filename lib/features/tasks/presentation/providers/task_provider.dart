import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/warning_dialog.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/dto/request/task_request_dto.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/get_sample_tasks_usecase.dart';
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

  final int _pageSize = 10;

  int _totalTasks = 0;
  int get totalTasks => _totalTasks;

  Future<bool> _getSampleTasks({
    required BuildContext context,
  }) async {
    final params = TaskPageRequestDTO(
      pageNumber: currentPage,
      pageSize: _pageSize,
    );
    final result = await _getSampleTasksUsecase(params);
    bool isLastPage = false;
    result.fold(
      (error) {
        debugPrint('$error');
        _error = true;
      },
      (taskPageResult) {
        _totalTasks = taskPageResult.total;
        _tasks.addAll(taskPageResult.tasks);
        isLastPage = taskPageResult.isLastPage;
        _currentPage++;
      },
    );

    return isLastPage;
  }

  deleteTask({required BuildContext context,required TaskModel task}) {
    _totalTasks--;
    _tasks.remove(task);
    _updateWidgetOnScreen();
    context.read<TaskScrollProvider>().checkScrollExtent(context);
  }

  updateTask({
    required BuildContext context,
    required TaskModel task,
  }) {
    int index = _tasks.indexWhere((t)=> t.id == task.id);
    _tasks[index] = task.copyWith(completed: !_tasks[index].completed);
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

  void _clear(){
    _currentPage = 1;
    _tasks.clear();
    _error = false;
    _totalTasks = 0;
  }

  void refreshSamplePage(BuildContext context){
    _showWarningDialog(
      context: context,
      text: 'If you proceed, all current tasks will be replaced by new ones. This action cannot be undone.',
      onOkPressed: (dialogContext) => _onRefreshConfirm(
        context,
      ),
      okButtonColor: AppColors.webHighlight
    );
  }

  Future<void> _showWarningDialog({
    required BuildContext context,
    required String text,
    required Function(BuildContext) onOkPressed,
    required Color okButtonColor
  }) {
    return showDialog(context: context, builder: (dialogContext){
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.0),
      body: Center(
        child: WarningDialog(
          title: text,
          onOkPressed: ()=> onOkPressed(dialogContext),
          okButtonColor: okButtonColor,
        ),
      ),
    );
  });
  }

  void _onRefreshConfirm(
     BuildContext context,
  ) {
    _clear();
    _loading = true;
    _updateWidgetOnScreen();
    getFirstSamplePage(context);
  }

  deleteAllTasks(BuildContext context) {
    _showWarningDialog(
      context: context,
      text: 'This action will delete all your tasks. This action cannot be undone.',
      onOkPressed: (dialogContext){
        _tasks.clear();
        _updateWidgetOnScreen();
      },
      okButtonColor: AppColors.deleteHighlight
    );
    
  }
}
