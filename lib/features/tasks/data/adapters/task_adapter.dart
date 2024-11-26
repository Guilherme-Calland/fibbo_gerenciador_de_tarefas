import 'package:gerenciador_de_tarefas/features/tasks/data/dto/task_response_dto.dart';

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
}