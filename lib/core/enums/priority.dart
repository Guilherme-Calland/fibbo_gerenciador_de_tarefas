enum TaskPriority {
  low, medium, high
}

extension TaskPriorityExtension on TaskPriority {
  String get label {
    switch (this) {
      case TaskPriority.low:
        return 'Low' ;
      case TaskPriority.medium:
        return 'Medium' ;
      case TaskPriority.high:
        return 'High';
    }
  }
}