
import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';


class LabeledButton extends StatelessWidget {
  const LabeledButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.label,
  });

  final IconData icon;
  final Function() onTap;
  final String? label;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(label != null)
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(label!),
        ),
        const SizedBox(width: 8.0,),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Center(
              child: Icon(icon, color: Colors.white,size: 32,),
            ),
          ),
        ),
      ],
    );
  }
}