import 'package:equatable/equatable.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority.dart';
import 'package:gerenciador_de_tarefas/core/hive/hive_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'task.g.dart';

@HiveType(typeId: HiveManager.taskModelTypeId)
class TaskModel extends Equatable{

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final bool completed;

  @HiveField(4)
  final TaskPriority priority;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.completed = false,
    required this.priority,
  });

  @override
  List<Object?> get props => [id];

  const TaskModel.empty()
    :id = 0,
    title = '',
    description = null,
    completed = false,
    priority = TaskPriority.low;
  
  TaskModel copyWith({
    String? title,
    String? description,
    bool? completed,
    TaskPriority? priority,
  }) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
    );
  }

}