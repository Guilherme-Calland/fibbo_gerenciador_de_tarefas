import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority/priority.dart';

class FilterProvider extends ChangeNotifier{
  bool _expanded = false;
  bool get expanded => _expanded;

  List<TaskPriority> _priorities = [];
  List<TaskPriority> get priorities => _priorities;

  toggleFiltersVisibility() {
    _expanded = !_expanded;
    notifyListeners();
  }

  hasActiveFilters() {
    return priorities.isNotEmpty;
  }
  
  addNewPriorityFilter(TaskPriority value){
    if(_priorities.contains(value)){
      _priorities.remove(value);
    }else{
      _priorities.add(value);
    }

    bool allPrioritiesSelected = _priorities.length == TaskPriority.values.length;
    if(allPrioritiesSelected){
      _priorities.clear();
    }

    notifyListeners();
  }

}