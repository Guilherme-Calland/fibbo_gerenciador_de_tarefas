class TaskDTO{
  final String title;
  final String? description;
  final int priority;
  final bool completed;

  TaskDTO({
    required this.title,
    required this.description,
    required this.priority,
    required this.completed
  });
}