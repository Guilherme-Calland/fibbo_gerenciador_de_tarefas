
import 'package:flutter/widgets.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority.dart';

class PriorityWidget extends StatelessWidget {
  const PriorityWidget(this.priority, {
    super.key,
  });

  final TaskPriority priority;

  @override
  Widget build(BuildContext context) {
    return Text(
      'prority',
      style: TextStyle(
        color: _priorityColor,
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
