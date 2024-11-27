import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/constants/decorations.dart';
import 'package:gerenciador_de_tarefas/core/widgets/loading_indicator.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/task_provider.dart';
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
          if (provider.loading) {
            return const Center(
              child: LoadingIndicator(),
            );
          }
          if (provider.error) {
            return const Center(
              child: Text("Something is wrong"),
            );
          }
          if(provider.tasks.isEmpty){
            return Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                    color: AppColors.foregroundColor,
                    borderRadius: AppDecorations.borderRadius,
                    boxShadow: AppDecorations.shadow),
                child: const Text(
                  "Task list empty, add a new task!",
                  style: TextStyle(fontSize: 32,),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              ListView.builder(
                itemCount: provider.tasks.length,
                itemBuilder: (context, index) {
                  final model = provider.tasks[index];
                  const horizontalPadding = 16.0;
                  bool firstItem = index == 0;
                  final double topPadding = firstItem ? 0.0 : 8.0;
                  return Padding(
                    padding: EdgeInsets.only(
                      left: horizontalPadding,
                      right: horizontalPadding,
                      top: topPadding,
                    ),
                    child: TaskWidget(model),
                  );
                },
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
  
  _getSampleTasks(BuildContext context) {
    final provider = context.read<TaskProvider>();
    provider.getSampleTasks();
    provider.showLoading(false);
  }
}
