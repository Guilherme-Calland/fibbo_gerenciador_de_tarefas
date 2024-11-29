
import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority/priority.dart';

class PriorityWidget extends StatelessWidget {
  const PriorityWidget(this.priority, {
    super.key,
  });

  final TaskPriority priority;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14,
      width: 14,
      decoration: BoxDecoration(
        color: _priorityColor,
        borderRadius: BorderRadius.circular(100)
      ),
    );
  }

  Color get _priorityColor {
    switch(priority){
      case TaskPriority.low:
        return AppColors.priorityLow;
      case TaskPriority.medium:
        return AppColors.priorityMedium;
      case TaskPriority.high:
        return AppColors.priorityHigh;
    }
  }
}
