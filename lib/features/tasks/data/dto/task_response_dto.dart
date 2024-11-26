class TaskResponseDTO{
  final int id;
  final String title;
  final String? description;
  final int priority;
  final bool completed;

  TaskResponseDTO({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.completed
  });
}