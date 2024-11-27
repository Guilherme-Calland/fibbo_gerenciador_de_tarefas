
import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/constants/decorations.dart';

class LabeledButton extends StatelessWidget {
  const LabeledButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.label,
    required this.color,
    required this.active
  });

  final IconData icon;
  final Function() onTap;
  final String? label;
  final Color color;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(label != null)
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 100
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: AppColors.foregroundColor,
              borderRadius: AppDecorations.borderRadiusSmall,
              boxShadow: AppDecorations.shadow
            ),
            child: Text(label!, style: const TextStyle(fontSize: 16.0),)
          ),
        ),
        GestureDetector(
          onTap: active ? onTap : null,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: active ? color: AppColors.inactiveColor,
              borderRadius: AppDecorations.borderRadius,
              boxShadow: AppDecorations.shadow,
            ),
            
            child: Center(
              child: Icon(icon, color: AppColors.foregroundColor ,size: 32,),
            ),
          ),
        ),
      ],
    );
  }
}