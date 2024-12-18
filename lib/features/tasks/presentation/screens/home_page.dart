import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/constants/routes.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/create_task_provider.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/filter_provider.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/complete_filter_labels.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/filter_icon.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/list_order_labels.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/loading_indicator.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_provider.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/create_task_suggestion_button.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/labeled_button.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/menu_button.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/priority_filter.dart';
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
                  const SizedBox(height: 12.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Order:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColors.inactiveColor,
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                ListOrderLabels(
                                  value: taskProvider.listOrder,
                                  onSelected: taskProvider.changeListOrder,
                                )
                              ],
                            ),
                            Consumer<FilterProvider>(
                              builder: (context, provider, _) {
                                return FilterIcon(
                                  onTap: provider.toggleFiltersVisibility,
                                  hasActiveFilters: taskProvider.hasActiveFilters(),
                                  expanded: provider.expanded,
                                );
                              }
                            ),
                          ],
                        ),
                        Consumer<FilterProvider>(
                          builder: (context, provider, _) {
                            return Visibility(
                              visible: provider.expanded,
                              child: Column(
                                children: [
                                  const SizedBox(height: 8.0),
                                  CompleteFilterLabels(
                                    value: taskProvider.completeFilter,
                                    onSelected: (val){
                                      taskProvider.changeFilter(val);
                                    },
                                  ),
                                  const SizedBox(height: 8.0),
                                  PriorityFilter(
                                    selectedPriorities: taskProvider.priorities,
                                    onPrioritySelected: (val) =>
                                      taskProvider.addNewPriorityFilter(
                                      context: context,
                                      value: val,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        ),
                    
                      ],
                    ),
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
                                taskProvider.toggleTaskComplete(model.id!);
                              },
                              onDeletePressed: () => taskProvider.deleteTask(model.id!),
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
                  actionButtons: (closeMenu) => [
                    LabeledButton(
                      active: !taskProvider.loading,
                      icon: Icons.add,
                      onTap: (){
                        closeMenu();
                        _goToCreateTaskPage(context: context);
                      },
                      label: "Create new task",
                      color: AppColors.addHighlight,
                    ),
                    LabeledButton(
                      active: !taskProvider.loading,
                      icon: Icons.cloud_outlined,
                      onTap: (){
                        closeMenu();
                        taskProvider.refreshSamplePage(context);
                      },
                      label: "Load sample tasks from the internet",
                      color: AppColors.webHighlight,
                    ),
                    LabeledButton(
                      active: !taskProvider.loading,
                      icon: Icons.delete,
                      onTap: (){
                        closeMenu();
                        taskProvider.deleteAllTasks(context);
                      },
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
    final createTaskProvider = context.read<CreateTaskProvider>();
    createTaskProvider.onInit(task);
    Navigator.pushNamed(context, AppRoutePaths.create, arguments: task);
  }
  
  _getTasksFromLocalStorage(BuildContext context) {
    context.read<TaskProvider>().getTasksFromLocalStorage();
  }
}
