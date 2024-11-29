import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/constants/routes.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/create_task_provider.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/complete_filter_labels.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/loading_indicator.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_provider.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/create_task_suggestion_button.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/labeled_button.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/menu_button.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/task_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage(BuildContext context, {super.key}) {
    WidgetsBinding.instance
      .addPostFrameCallback((_)async{
        await _getTasksFromLocalStorage(context);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColorDark,
        title: const Text(
          "Task Manager",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.foregroundColor,
          ),
        ),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              Column(
                children: [
                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      CompleteFilterLabels(
                        value: taskProvider.completeFilter,
                        onSelected: (val){
                          taskProvider.changeFilter(val);
                        },
                      ),
                      const SizedBox(width: 4.0,),
                      const Row(
                        children: [
                          Icon(Icons.tune, color: AppColors.secondaryText,),
                          SizedBox(width: 4.0),
                          Icon(Icons.keyboard_arrow_down, color: AppColors.secondaryText)
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: (){
                      if (taskProvider.loading) {
                        return const Center(
                          child: LoadingIndicator(),
                        );
                      } else if (taskProvider.error){
                        return const Center(
                          child: Text("An error has occurred"),
                        );
                      }
                      else if (taskProvider.tasks.isEmpty ){
                        return Center(
                          child: CreateTaskSuggestionButton(
                            onTap: () => _goToCreateTaskPage(context: context),
                          ),
                        );
                      }
                      else{
                        return ListView.builder(
                          itemCount: taskProvider.tasks.length,
                          itemBuilder: (context, index) {
                            final model = taskProvider.tasks[index];
                            const horizontalPadding = 16.0;
                            
                            return TaskCard(
                              model,
                              padding: const EdgeInsets.only(
                                left: horizontalPadding,
                                right: horizontalPadding,
                                top:  8
                              ),
                              onTap: ()=>  _goToCreateTaskPage(context: context, index: index, task: model),
                              onCompleteToggle: (){
                                taskProvider.editingIndex = index;
                                taskProvider.toggleTaskComplete(index);
                              },
                              onDeletePressed: () => taskProvider.deleteTask(index),
                            );
                          },
                        );
                      }
                    }()
                  )
                ],
              ),
              
              Positioned(
                right: 16,
                bottom: 32,
                child: MenuButton(
                  active: !taskProvider.loading,
                  icon: Icons.menu,
                  actionButtons: [
                    LabeledButton(
                      active: !taskProvider.loading,
                      icon: Icons.add,
                      onTap: () => _goToCreateTaskPage(context: context),
                      label: "Create new task",
                      color: AppColors.addHighlight,
                    ),
                    LabeledButton(
                      active: !taskProvider.loading,
                      icon: Icons.cloud_outlined,
                      onTap: () => taskProvider.refreshSamplePage(context),
                      label: "Load sample tasks from the internet",
                      color: AppColors.webHighlight,
                    ),
                    LabeledButton(
                      active: !taskProvider.loading,
                      icon: Icons.delete,
                      onTap: () => taskProvider.deleteAllTasks(context),
                      label: "Delete all tasks",
                      color: AppColors.deleteHighlight,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
  
  _goToCreateTaskPage({
    required BuildContext context,
    int? index,
    TaskModel? task,
  }) {
    final taskProvider = context.read<TaskProvider>();
    bool creatingNewTask = task == null;
    if(creatingNewTask){
      taskProvider.editingIndex = null;
    }else{
      taskProvider.editingIndex = index;
    }

    final createTaskProvider = context.read<CreateTaskProvider>();
    createTaskProvider.onInit(task: task, index: index);
    Navigator.pushNamed(context, AppRoutePaths.create, arguments: task);
  }
  
  _getTasksFromLocalStorage(BuildContext context) {
    context.read<TaskProvider>().getTasksFromLocalStorage();
  }
}
