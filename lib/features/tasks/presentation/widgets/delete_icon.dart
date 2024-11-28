import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';

class DeleteIcon extends StatelessWidget {
  const DeleteIcon({
    super.key,
    required this.onTap
  });

  final Function() onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.close,
        color: AppColors.backgroundIcon,
      ),
    );
  }
}
