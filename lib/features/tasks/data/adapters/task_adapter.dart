import 'package:gerenciador_de_tarefas/core/enums/priority/priority.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/dto/task_dto.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';

class TaskAdapter{
  static TaskDTO fromJson(Map<String, dynamic> json){
    return TaskDTO(
      id: json["id"] as int,
      title: json["todo"] as String,
      description: json["description"] as String?,
      priority: json["priority"] as int? ?? 0,
      completed: json["completed"] as bool,
    );
  }

  static TaskModel fromDTO(TaskDTO dto){
    return TaskModel(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      priority: TaskPriority.values[dto.priority],
      completed: dto.completed,
    );
  }

  static TaskDTO toDTO(TaskModel newTask) {
    return TaskDTO(
      id: newTask.id,
      title: newTask.title,
      description: newTask.description,
      priority: TaskPriority.values.indexOf(newTask.priority),
      completed: newTask.completed,
    );
  }
}