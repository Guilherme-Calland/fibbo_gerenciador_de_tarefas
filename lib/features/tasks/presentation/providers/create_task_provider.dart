import 'package:flutter/widgets.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority/priority.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/save_local_task_usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_provider.dart';
import 'package:provider/provider.dart';

class CreateTaskProvider extends ChangeNotifier{
  final SaveLocalTaskUsecase saveLocalTaskUsecase;

  CreateTaskProvider({
    required this.saveLocalTaskUsecase
  });

  final _titleController = TextEditingController();
  TextEditingController get titleController => _titleController;

  final _descriptionController = TextEditingController();
  TextEditingController get descriptionController => _descriptionController;

  bool _titleError = false;
  bool get titleError => _titleError;

  TaskPriority _priority = TaskPriority.low;
  TaskPriority get priority => _priority;

  _clear(){
    _titleController.clear();
    _descriptionController.clear();
    _titleError = false;
    _priority = TaskPriority.low;
  }

  void onPriorityChanged(TaskPriority? value) {
    _priority = value!;
    debugPrint("\nfibbo, priority${value?.label}\n");
    _updateWidgetsOnScreen();
  }

  createTask(BuildContext context){
    _titleError = _titleController.text.isEmpty;
    if(_titleError){
      _updateWidgetsOnScreen();
    }
    bool validFields = !_titleError;
    if(validFields){
      final newTask = TaskModel(
        title: _titleController.text,
        description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
        priority: priority,
      );

      context.read<TaskProvider>().addNewTask(newTask);
      Navigator.pop(context);

      _saveTaskInLocalStorage(newTask);
    }
  }

  void _updateWidgetsOnScreen(){
    notifyListeners();
  }
  
  Future<void> _saveTaskInLocalStorage(TaskModel newTask) async{
    final result = await saveLocalTaskUsecase(newTask);
      result.fold((l){
        debugPrint('$l');
      }, (r){});
  }

  void _initalizeEditTaskFields(TaskModel model) {
    _titleController.text = model.title;
    _descriptionController.text = model.description??"";
    _priority = model.priority;
  }

  void onInit(TaskModel? task) {
    bool createingNewTask = task == null;
    if(createingNewTask){
      _clear();
    }else{
      _initalizeEditTaskFields(task!);
    }
  }
}