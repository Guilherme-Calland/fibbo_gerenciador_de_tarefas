import 'package:flutter/widgets.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority.dart';

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
    notifyListeners();
  }
}