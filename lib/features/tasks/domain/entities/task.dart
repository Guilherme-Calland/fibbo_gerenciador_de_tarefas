import 'package:equatable/equatable.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority.dart';

class TaskModel extends Equatable{
  final int id;
  final String title;
  final String? description;
  final bool completed;
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