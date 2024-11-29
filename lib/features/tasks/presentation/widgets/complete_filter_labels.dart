
import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/enums/complete_filter.dart';

class CompleteFilterLabels extends StatelessWidget {
  const CompleteFilterLabels({
    super.key, this.value, required this.onSelected, 
  });

  final CompleteFilter? value;
  final Function(CompleteFilter?) onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
    children: List.generate(CompleteFilter.values.length, (index){
      final filter = CompleteFilter.values[index];
      final bool selected = value == filter;
      return Row(
        children: [
          if(index != 0)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 16,
            width: 1,
            color: AppColors.borderColor,
          ),
          GestureDetector(
            onTap: (){
              onSelected(filter);
            },
            child: Text(filter.label, style: TextStyle(
              fontSize: 16,
              color: selected ? AppColors.mainColorDark : AppColors.inactiveColor,
              fontWeight: selected ? FontWeight.bold : null
            ),),
          ),
        ],
      );
    },),
        );
  }
}

