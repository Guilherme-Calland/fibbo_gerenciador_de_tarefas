import 'package:gerenciador_de_tarefas/core/hive/hive_manager.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';
import 'package:hive/hive.dart';
part 'task_page.g.dart';

@HiveType(typeId: HiveManager.taskPageTypeId)
class TaskPage{

  @HiveField(0)
  final List<TaskModel> tasks;

  @HiveField(1)
  final int total;

  const TaskPage({
    required this.tasks,
    required this.total
  });

  TaskPage.empty() :
    tasks = const [TaskModel.empty()],
    total = 1;
}