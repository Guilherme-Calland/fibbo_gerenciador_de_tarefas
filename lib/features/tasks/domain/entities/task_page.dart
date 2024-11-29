import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';

class TaskPage{
  final List<TaskModel> tasks;
  final int total;

  const TaskPage({
    required this.tasks,
    required this.total
  });

  TaskPage.empty() :
    tasks = const [TaskModel.empty()],
    total = 1;
}