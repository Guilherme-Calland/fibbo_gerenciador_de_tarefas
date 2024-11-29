import 'package:gerenciador_de_tarefas/core/enums/priority/priority.dart';
import 'package:gerenciador_de_tarefas/core/hive/hive_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'task.g.dart';

@HiveType(typeId: HiveManager.taskModelTypeId)
class TaskModel{
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  final bool completed;

  @HiveField(3)
  final TaskPriority priority;

  const TaskModel({
    required this.title,
    required this.description,
    this.completed = false,
    required this.priority,
  });

  const TaskModel.empty():
    title = '',
    description = null,
    completed = false,
    priority = TaskPriority.low;

  TaskModel copy(TaskModel editTask){
    return editTask;
  }
  
  TaskModel copyWith({
    String? title,
    String? description,
    bool? completed,
    TaskPriority? priority,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
    );
  }

}