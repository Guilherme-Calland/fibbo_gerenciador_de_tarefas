
import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority/priority.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/priority_widget.dart';

class PriorityFilter extends StatelessWidget {
  const PriorityFilter({
    super.key,
    required this.selectedPriorities,
    required this.onPrioritySelected,
  });

  final List<TaskPriority> selectedPriorities;
  final Function(TaskPriority) onPrioritySelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(TaskPriority.values.length, (index){
        final value = TaskPriority.values[index];
        bool selected = selectedPriorities.contains(value);
        bool firstItem = index == 0;
        return GestureDetector(
          onTap: (){
            onPrioritySelected(value);
          },
          child: Row(
            children: [
              if(!firstItem)
              const SizedBox(width: 16.0,),
              PriorityWidget(value),
              const SizedBox(width: 4.0),
              Text(
              value.label,
              style: TextStyle(
                color: selected
                    ? AppColors.mainColorDark
                    : AppColors.inactiveColor,
                fontWeight: selected ? FontWeight.bold : null,
              ),
            ),
            ],
          ),
        );
      })
    );
  }
}

