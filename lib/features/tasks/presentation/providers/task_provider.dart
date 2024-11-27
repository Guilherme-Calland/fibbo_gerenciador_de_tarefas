import 'package:flutter/foundation.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/get_sample_tasks_usecase.dart';

class TaskProvider extends ChangeNotifier{
  final GetSampleTasksUsecase getSampleTasksUsecase;
  TaskProvider({required this.getSampleTasksUsecase});

  bool _loading = false;
  bool get loading => _loading;
}