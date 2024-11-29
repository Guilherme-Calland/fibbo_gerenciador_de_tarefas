import 'package:gerenciador_de_tarefas/core/enums/priority/priority.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/dto/response/task_response_dto.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';

class TaskAdapter{
  static TaskResponseDTO fromJson(Map<String, dynamic> json){
    return TaskResponseDTO(
      id: json["id"] as int,
      title: json["todo"] as String,
      description: json["description"] as String?,
      priority: json["priority"] as int? ?? 0,
      completed: json["completed"] as bool,
    );
  }

  static TaskModel fromDTO(TaskResponseDTO dto){
    return TaskModel(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      priority: TaskPriority.values[dto.priority],
      completed: dto.completed,
    );
  }
}