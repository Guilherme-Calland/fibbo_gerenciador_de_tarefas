import 'package:equatable/equatable.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority.dart';

class TaskModel extends Equatable{
  final int? id;
  final String title;
  final String? description;
  final bool completed;
  final TaskPriority priority;

  const TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.completed,
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
}