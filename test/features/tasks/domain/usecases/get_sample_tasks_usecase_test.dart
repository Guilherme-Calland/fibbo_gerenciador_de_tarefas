import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciador_de_tarefas/features/tasks/data/dto/request/task_request_dto.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_page/task_page.dart';
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

  final tResponse = TaskPage.empty();
  final tParams = TaskPageRequestDTO(pageNumber: 10, pageSize: 1);

  test("should call [TaskRepository.getSampleTasks]", ()async{
    when(()=> repository.getSampleTasks(tParams))
    .thenAnswer((_)async=> Right(tResponse));

    final result = await usecase(tParams);

    expect(result, equals(Right<dynamic, TaskPage>(tResponse)));
    verify(()=> repository.getSampleTasks(tParams)).called(1);
    verifyNoMoreInteractions(repository);
  });
}