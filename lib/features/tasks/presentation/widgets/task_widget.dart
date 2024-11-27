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
      decoration: BoxDecoration(
        color: AppColors.foregroundColor,
        borderRadius: AppDecorations.borderRadiusSmall,
        boxShadow: AppDecorations.shadow
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 1.0, right: 3.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: PriorityWidget(model.priority),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: const TextStyle(fontSize: 16),
                ),
                if(model.description != null)
                  Text(model.description!, style: const TextStyle(color: AppColors.inactiveColor),),
                Text(model.completed? 'completed' : 'not completed'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
