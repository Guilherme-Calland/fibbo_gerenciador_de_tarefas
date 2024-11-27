import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/widgets/loading_indicator.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_provider.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/create_task_suggestion_button.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/labeled_button.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/menu_button.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/task_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage(BuildContext context, {super.key}){
    WidgetsBinding.instance.addPostFrameCallback((_)=> _getSampleTasks(context));
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
        builder: (context, provider, _) {
          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              if (provider.loading)
              const Center(
                child: LoadingIndicator(),
              )
              else if (provider.error) 
              const Center(
                child: Text("Something is wrong"),
              )
              else if(provider.tasks.isEmpty)
              const Center(
                child: CreateTaskSuggestionButton(),
              )

              else              
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                  itemCount: provider.tasks.length,
                  itemBuilder: (context, index) {
                    final model = provider.tasks[index];
                    const horizontalPadding = 16.0;
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: horizontalPadding,
                        right: horizontalPadding,
                        top: 16.0,
                      ),
                      child: TaskWidget(model),
                    );
                  },
                ),
              ),
              Positioned(
                right: 24,
                bottom: 32,
                child: MenuButton(
                  active: !provider.loading,
                  icon: Icons.menu,
                  actionButtons: [
                    LabeledButton(
                      active: !provider.loading,
                      icon: Icons.add,
                      onTap: () {},
                      label: "Create new task",
                      color: AppColors.addHighlight,
                    ),
                    LabeledButton(
                      active: !provider.loading,
                      icon: Icons.cloud_outlined,
                      onTap: () {},
                      label: "Fetch sample tasks from web",
                      color: AppColors.webHighlight,
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
  
  Future<void> _getSampleTasks(BuildContext context) async{
    final provider = context.read<TaskProvider>();
    await provider.getSampleTasks();
    provider.loading = false;
    provider.updateScreen();
  }
}

