import 'package:flutter/widgets.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority/priority.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_provider.dart';
import 'package:provider/provider.dart';

class CreateTaskProvider extends ChangeNotifier{
  CreateTaskProvider();

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
    _updateWidgetsOnScreen();
  }

  bool createTask({required BuildContext context, TaskModel? task}){
    _titleError = _titleController.text.trim().isEmpty;
    if(_titleError){
      _updateWidgetsOnScreen();
    }
    bool validFields = !_titleError;
    if(validFields){
      final newTask = TaskModel(
        id: task?.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
        priority: priority,
        completed: task?.completed ?? false
      );

      final taskProvider = context.read<TaskProvider>();
      bool creatingNewTask = task == null;
      if(creatingNewTask){
        taskProvider.addNewTask(newTask);
      }else{
        taskProvider.editTask(newTask);
      }
      return true;
    }else{
      return false;
    }
  }

  void _updateWidgetsOnScreen(){
    notifyListeners();
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
      _initalizeEditTaskFields(task);
    }
  }
}