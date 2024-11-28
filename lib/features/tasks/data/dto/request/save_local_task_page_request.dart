import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_page/task_page.dart';

class SaveLocalTaskPageRequest{
  final int pageNumber;
  final TaskPage taskPage;

  SaveLocalTaskPageRequest({
    required this.pageNumber,
    required this.taskPage,
  });
}