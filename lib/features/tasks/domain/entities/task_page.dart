import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';

class TaskPage{
  final List<TaskModel> tasks;
  final bool isLastPage;

  const TaskPage({
    required this.tasks,
    required this.isLastPage,
  });

  TaskPage.empty()
    : isLastPage = false,
    tasks = const [TaskModel.empty()];
}