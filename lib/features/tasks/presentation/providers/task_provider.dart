import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/usecase/usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/delete_all_local_tasks_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/get_local_task_page_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/save_local_task_page_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/warning_dialog.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/get_sample_tasks_usecase.dart';

class TaskProvider extends ChangeNotifier{
  final GetSampleTasksUsecase getSampleTasksUsecase;
  final SaveLocalTaskPageUsecase saveLocalTaskPageUsecase;
  final GetLocalTaskPageUsecase getLocalTaskPageUsecase;
  final DeleteAllLocalTasksUsecase deleteAllLocalTasksUsecase;

  TaskProvider({
    required this.getSampleTasksUsecase,
    required this.saveLocalTaskPageUsecase,
    required this.getLocalTaskPageUsecase,
    required this.deleteAllLocalTasksUsecase,
  });

  bool _loading = true;
  bool get loading => _loading;

  bool _error = false;
  bool get error => _error;

  final List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  void _updateWidgetOnScreen(){
    notifyListeners();
  }

  final int _pageSize = 30;

  Future<void> _getSampleTasks() async {

    final result = await getSampleTasksUsecase(NoParams());
    result.fold(
      (error) {
        debugPrint('$error');
        _error = true;
      },
      (taskPageResult) async{
        _currentTaskPage.clear();
        _currentTaskPage.addAll(taskPageResult.tasks);
        _tasks.addAll(taskPageResult.tasks);
        _saveTaskPageInLocalStorage();
      },
    );

  }

  deleteTask({required BuildContext context,required TaskModel task}) {
    _tasks.remove(task);
    _updateWidgetOnScreen();
  }

  updateTask({
    required BuildContext context,
    required TaskModel task,
  }) {
    int index = _tasks.indexWhere((t)=> t.id == task.id);
    _tasks[index] = task.copyWith(completed: !_tasks[index].completed);
  }

  final List<TaskModel> _currentTaskPage = [];

  Future<void> getSamplePage() async {
    await _getSampleTasks();
    _loading = false;
    _updateWidgetOnScreen();
  }

  void _clear(){
    _tasks.clear();
    _error = false;
    _currentTaskPage.clear();
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
  ) async{
    _clear();
    await _deleteAllTasksFromLocalStorage();
    _loading = true;
    _updateWidgetOnScreen();
    if(context.mounted){
      await _refreshSampleTasks();
    }
  }

  deleteAllTasks(BuildContext context) {
    _showWarningDialog(
      context: context,
      text: 'This action will delete all your tasks. This action cannot be undone.',
      onOkPressed: (dialogContext)async{
        _tasks.clear();
        _updateWidgetOnScreen();
        _deleteAllTasksFromLocalStorage();
      },
      okButtonColor: AppColors.deleteHighlight
    );
    
  }

  Future<void> _deleteAllTasksFromLocalStorage() async {
    final result = await deleteAllLocalTasksUsecase(NoParams());
    result.fold((l){
      debugPrint("$l");
    }, (r){});
  }

  Future<void> getTasksFromLocalStorage() async{
    _clear();
    final result = await getLocalTaskPageUsecase(NoParams());
    result.fold((l){
      debugPrint('$l, ${StackTrace.current}');
    }, (taskPage){
      _tasks.addAll(taskPage);
    });
    _loading = false;
    _updateWidgetOnScreen();
  }
  
  Future<void> _refreshSampleTasks() async{
    _clear();
    _loading = true;
    _updateWidgetOnScreen();

    await _getSampleTasks();

    _loading = false;
    _updateWidgetOnScreen();
  }

  Future<void> _saveTaskPageInLocalStorage()async{
    final result = await saveLocalTaskPageUsecase(_tasks);
    result.fold((l){
      debugPrint('$l');
    }, (r){});
  }
}
