import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';

class TaskPage{
  final List<TaskModel> tasks;
  final bool isLastPage;
  final int total;

  const TaskPage({
    required this.tasks,
    required this.isLastPage,
    required this.total
  });

  TaskPage.empty()
    : isLastPage = false,
    tasks = const [TaskModel.empty()],
    total = 1;
}