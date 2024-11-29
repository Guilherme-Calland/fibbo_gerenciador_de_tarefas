import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';

class FilterIcon extends StatelessWidget {
  const FilterIcon({
    super.key,
    required this.onTap,
    required this.hasActiveFilters,
    required this.expanded
  });

  final Function()onTap;
  final bool hasActiveFilters;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Row(
            children: [
              const Icon(Icons.tune, color: AppColors.secondaryText,),
              const SizedBox(width: 4.0),
              Icon(expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: AppColors.secondaryText),
            ],
          ),
          if(hasActiveFilters)
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      ),
    );
  }
}
