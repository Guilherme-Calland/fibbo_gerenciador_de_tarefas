import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/enums/complete_filter.dart';

class TaskFilterProvider extends ChangeNotifier{
  CompleteFilter? _completeFilter;
  CompleteFilter? get completeFilter => _completeFilter;

  changeFilter(CompleteFilter? value){
    _completeFilter = value;
    _updateScreenWidgets();
  }

  _updateScreenWidgets(){
    notifyListeners();
  }
}