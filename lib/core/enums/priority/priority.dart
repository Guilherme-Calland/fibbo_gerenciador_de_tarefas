
import 'package:gerenciador_de_tarefas/core/hive/hive_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'priority.g.dart';

@HiveType(typeId: HiveManager.taskPriorityTypeId)
enum TaskPriority {
  @HiveField(0)
  low, 
  
  @HiveField(1)
  medium, 
  
  @HiveField(2)
  high
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