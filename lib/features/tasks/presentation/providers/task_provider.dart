import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/enums/complete_filter.dart';
import 'package:gerenciador_de_tarefas/core/enums/list_order.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority/priority.dart';
import 'package:gerenciador_de_tarefas/core/usecase/usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/delete_all_local_tasks_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/delete_local_task_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/get_local_task_page_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/save_local_task_page_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/save_local_task_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/update_local_task_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/warning_dialog.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/get_sample_tasks_usecase.dart';

class TaskProvider extends ChangeNotifier{
  final GetSampleTasksUsecase getSampleTasksUsecase;
  final SaveLocalTaskPageUsecase saveLocalTaskPageUsecase;
  final GetLocalTaskPageUsecase getLocalTaskPageUsecase;
  final DeleteAllLocalTasksUsecase deleteAllLocalTasksUsecase;
  final DeleteLocalTaskUsecase deleteLocalTaskUsecase;
  final SaveLocalTaskUsecase saveLocalTaskUsecase;
  final UpdateLocalTaskUsecase updateLocalTaskUsecase;

  TaskProvider({
    required this.getSampleTasksUsecase,
    required this.saveLocalTaskPageUsecase,
    required this.getLocalTaskPageUsecase,
    required this.deleteAllLocalTasksUsecase,
    required this.deleteLocalTaskUsecase,
    required this.saveLocalTaskUsecase,
    required this.updateLocalTaskUsecase
  });

  bool _loading = true;
  bool get loading => _loading;

  bool _error = false;
  bool get error => _error;

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  ListOrder _listOrder = ListOrder.byPriority;
  ListOrder get listOrder => _listOrder;

  void changeListOrder(ListOrder value){
    if(_listOrder == value){
      return;
    }
    _listOrder = value;
    _tasks.sort(_sortTaskOrder);
    _updateWidgetOnScreen();
  }

  void _updateWidgetOnScreen(){
    notifyListeners();
  }

  Future<void> _getSampleTasks() async {
    final result = await getSampleTasksUsecase(NoParams());
    result.fold(
      (error) {
        debugPrint('$error');
        _error = true;
      },
      (taskPageResult) async{
        _tasks.addAll(taskPageResult);
        _tasks.sort(_sortTaskOrder);
        _saveTaskPageInLocalStorage();
      },
    );

  }

  deleteTask(int id) {
    _tasks.removeWhere((t)=> t.id == id);
    _updateWidgetOnScreen();
    _deleteLocalTask(id);
  }

  Future<void> _deleteLocalTask(int id) async {
    final result = await deleteLocalTaskUsecase.call(id);
    result.fold((l){
      debugPrint('$l');
    }, (r){});
  }

  Future<void> getSamplePage() async {
    await _getSampleTasks();
    _loading = false;
    _updateWidgetOnScreen();
  }

  void _clear(){
    _tasks.clear();
    _error = false;
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
      _tasks.sort(_sortTaskOrder);
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

  Future<void> addNewTask(TaskModel newTask)async{
    int? id = await _saveTaskInLocalStorage(newTask);
    if(id!= null){
      _tasks.add(newTask.copyWith(id: id));
      _tasks.sort(_sortTaskOrder);
    }
    _updateWidgetOnScreen();
  }

  int _sortByPriority(a, b) {
    int priorityComparison = b.priority.index.compareTo(a.priority.index);
    if (priorityComparison == 0) {
      return a.id!.compareTo(b.id!);
    }
    return priorityComparison;
  }

  int _sortByDate(a,b){
    return a.id!.compareTo(b.id!);
  }

  int _sortTaskOrder(a,b){
    switch(_listOrder){
      case ListOrder.byPriority:
        return _sortByPriority(a, b);
      case ListOrder.byDate:
        return _sortByDate(a, b);
    }
  }

  void editTask(TaskModel newTask){
    int index = _tasks.indexWhere((t)=> t.id == newTask.id);
    _tasks[index] = _tasks[index].copy(newTask);
    _tasks.sort(_sortTaskOrder);

    _updateWidgetOnScreen();
    _updateTaskInLocalStorage(newTask);
  }

  void toggleTaskComplete(int id){
    int index = _tasks.indexWhere((t)=> t.id == id);
    _tasks[index] = _tasks[index].copyWith(completed: !_tasks[index].completed);
    _updateTaskInLocalStorage(_tasks[index]);
    _updateWidgetOnScreen();
  }

  Future<int?> _saveTaskInLocalStorage(TaskModel newTask) async {
    final result = await saveLocalTaskUsecase(newTask);
    late int? id;
    result.fold((l){
      debugPrint('$l');
    },(r){
      id = r;
    });
    return id;
  }
  
  Future<void> _updateTaskInLocalStorage(TaskModel newTask) async{
    final result = await updateLocalTaskUsecase(newTask);
    result.fold((l){
      debugPrint('$l');
    }, (r){});
  }


  //filters
  CompleteFilter? _completeFilter;
  CompleteFilter? get completeFilter => _completeFilter;

  Future<void> changeFilter(CompleteFilter? value)async{
    if(_completeFilter == value){
      _completeFilter = null;
    }else{
      _completeFilter = value;
    }
    await _filterTasks();
  }

  List<TaskPriority> _priorities = [];
  List<TaskPriority> get priorities => _priorities;

  Future<void> filterPriorities(List<TaskPriority> priorities) async{
    _priorities = priorities;
    await _filterTasks();
  }

  Future<void> _filterTasks() async {
    final allTasksResult = await getLocalTaskPageUsecase(NoParams());
    allTasksResult.fold((l){
      debugPrint('$l');
    }, (allTasks){
      List<TaskModel> filteredTasks = [];
      for(var task in allTasks){
        if(_passedCompletedFilter(task.completed) && _passedPriorityFilter(task.priority)){
          filteredTasks.add(task);
        }
      }
      _tasks = filteredTasks;
      _tasks.sort(_sortTaskOrder);
      _updateWidgetOnScreen();
    });
  }

  bool _passedPriorityFilter(TaskPriority priority){
    return _priorities.contains(priority) || _priorities.isEmpty;
  }
  
  bool _passedCompletedFilter(bool completed) {
    return _completeFilter == null || 
      (_completeFilter == CompleteFilter.complete && completed) || 
      (_completeFilter == CompleteFilter.pending && !completed);
  }
  
  addNewPriorityFilter({
    required BuildContext context,
    required TaskPriority value,
  }) {
    if (_priorities.contains(value)) {
      _priorities.remove(value);
    } else {
      _priorities.add(value);
    }

    bool allPrioritiesSelected = _priorities.length == TaskPriority.values.length;
    if(allPrioritiesSelected){
      _priorities.clear();
    }

    filterPriorities(_priorities);
  }

  hasActiveFilters() {
    return _priorities.isNotEmpty || _completeFilter != null;
  }
}
