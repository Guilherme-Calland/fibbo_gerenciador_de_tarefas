import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';

class FilterIcon extends StatelessWidget {
  const FilterIcon({
    super.key,
    required this.onTap,
    required this.hasActiveFilters,
  });

  final Function()onTap;
  final bool hasActiveFilters;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          const Row(
            children: [
              Icon(Icons.tune, color: AppColors.secondaryText,),
              SizedBox(width: 4.0),
              Icon(Icons.keyboard_arrow_down, color: AppColors.secondaryText)
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
