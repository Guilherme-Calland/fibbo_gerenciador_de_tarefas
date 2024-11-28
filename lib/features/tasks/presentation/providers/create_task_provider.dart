import 'package:flutter/widgets.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_provider.dart';
import 'package:provider/provider.dart';

class CreateTaskProvider extends ChangeNotifier{
  final _titleController = TextEditingController();
  TextEditingController get titleController => _titleController;

  final _descriptionController = TextEditingController();
  TextEditingController get descriptionController => _descriptionController;

  bool _titleError = false;
  bool get titleError => _titleError;

  TaskPriority _priority = TaskPriority.low;
  TaskPriority get priority => _priority;

  clear(){
    _titleController.clear();
    _descriptionController.clear();
    _titleError = false;
    _priority = TaskPriority.low;
  }

  void onPriorityChanged(TaskPriority? value) {
    _priority = value!;
    _updateWidgetsOnScreen();
  }

  createTask(BuildContext context) {
    _titleError = _titleController.text.isEmpty;

    bool validFields = !_titleError;
    if(!validFields){
      final int newTaskId = context.read<TaskProvider>().totalTasks + 1;
      final newTask = TaskModel(
        id: newTaskId,
        title: _titleController.text,
        description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
        priority: priority,
      );

      
    }
    _updateWidgetsOnScreen();
  }

  void _updateWidgetsOnScreen(){
    notifyListeners();
  }
}