import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciador_de_tarefas/core/usecase/usecase.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/usecases/get_sample_tasks_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../mock_repositories/mock_task_repository.dart';

void main() {
  late GetSampleTasksUsecase usecase;
  late MockTaskRepository repository;
  
  setUp((){
    repository = MockTaskRepository();
    usecase = GetSampleTasksUsecase(repository);
  });

  final tResponse = [const TaskModel.empty()];
  final tParams = NoParams();

  test("should call [TaskRepository.getSampleTasks]", ()async{
    when(()=> repository.getSampleTasks())
    .thenAnswer((_)async=> Right(tResponse));

    final result = await usecase(tParams);

    expect(result, equals(Right<dynamic, List<TaskModel>>(tResponse)));
    verify(()=> repository.getSampleTasks()).called(1);
    verifyNoMoreInteractions(repository);
  });
}