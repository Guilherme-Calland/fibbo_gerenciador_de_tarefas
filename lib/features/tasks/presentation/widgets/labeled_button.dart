
import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/decorations.dart';


class LabeledButton extends StatelessWidget {
  const LabeledButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.label,
    required this.color,
  });

  final IconData icon;
  final Function() onTap;
  final String? label;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(label != null)
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: AppDecorations.shadow
            ),
            child: Text(label!)
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: AppDecorations.shadow,
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