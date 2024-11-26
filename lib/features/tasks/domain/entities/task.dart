import 'package:equatable/equatable.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority.dart';

class Task extends Equatable{
  final int? id;
  final String title;
  final String description;
  final bool completed;
  final TaskPriority priority;

  const Task({
    this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.priority,
  });

  @override
  List<Object?> get props => [id];
}