import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/constants/routes.dart';
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
              if (taskProvider.loading)
                const Center(
                  child: LoadingIndicator(),
                )
              else if (taskProvider.error)
                const Center(
                  child: Text("An error has occurred"),
                )
              else if (taskProvider.tasks.isEmpty)
                const Center(
                  child: CreateTaskSuggestionButton(),
                )
              else
                ListView.builder(
                  itemCount: taskProvider.tasks.length,
                  itemBuilder: (context, index) {
                    final model = taskProvider.tasks[index];
                    const horizontalPadding = 16.0;
                    final lastItem = index == taskProvider.tasks.length - 1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TaskCard(
                          model,
                          padding: const EdgeInsets.only(
                            left: horizontalPadding,
                            right: horizontalPadding,
                            top: 8.0
                          ),
                          onCompleteToggle: () => taskProvider.updateTask(
                            context: context, task: model
                          ),
                          onDeletePressed: () => taskProvider.deleteTask(
                            context: context,
                            task: model,
                          ),
                        ),
                      ],
                    );
                  },
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
                      onTap: () => _goToCreateTaskPage(context),
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
  
  _goToCreateTaskPage(BuildContext context) => Navigator.pushNamed(context, AppRoutes.create);
  
  _getTasksFromLocalStorage(BuildContext context) {
    context.read<TaskProvider>().getFirstTasksFromLocalStorage();
  }
}

