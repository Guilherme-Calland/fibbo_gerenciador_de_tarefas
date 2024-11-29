import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier{
  bool _expanded = false;
  bool get expanded => _expanded;

  toggleFiltersVisibility() {
    _expanded = !_expanded;
    notifyListeners();
  }

  hasActiveFilters() {
    return true;
  }
}