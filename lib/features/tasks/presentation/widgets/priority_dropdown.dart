
import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/constants/decorations.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority/priority.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/priority_widget.dart';

class ProrityDropdown extends StatelessWidget {
  const ProrityDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final TaskPriority value;
  final Function(TaskPriority?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: AppDecorations.borderRadiusSmall,
        border: Border.all(color: AppColors.borderColor)
      ),
      child: DropdownButton<TaskPriority>(
        dropdownColor: AppColors.backgroundColor,
        value: value,
        items: TaskPriority.values
            .map<DropdownMenuItem<TaskPriority>>((TaskPriority value) {
          return DropdownMenuItem<TaskPriority>(
            value: value,
            child: Row(
              children: [
                PriorityWidget(value),
                const SizedBox(width: 8.0),
                Text(value.label),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
        borderRadius: AppDecorations.borderRadiusSmall,
      ),
    );
  }
}
