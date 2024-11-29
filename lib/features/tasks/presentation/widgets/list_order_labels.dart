import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/enums/list_order.dart';

class ListOrderLabels extends StatelessWidget {
  const ListOrderLabels({
    super.key, required this.value, required this.onSelected, 
  });

  final ListOrder value;
  final Function(ListOrder) onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
    children: List.generate(ListOrder.values.length, (index){
      final filter = ListOrder.values[index];
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
