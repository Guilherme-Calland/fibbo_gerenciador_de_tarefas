import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/constants/decorations.dart';
import 'package:gerenciador_de_tarefas/core/widgets/priority_widget.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget(
    this.model, {
    super.key,
  });

  final TaskModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.foregroundColor,
        borderRadius: AppDecorations.borderRadius,
        boxShadow: AppDecorations.shadow
      ),
      height: 100,
      width: double.infinity,
      child: Column(
        children: [
          Text(model.title),
          if(model.description != null)
          Text(model.description!),
          PriorityWidget(model.priority),
          Text(model.completed? 'completed' : 'not completed')
        ],
      ),
    );
  }
}
