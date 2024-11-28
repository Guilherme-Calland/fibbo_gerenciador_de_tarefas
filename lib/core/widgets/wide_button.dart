
import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/decorations.dart';

class WideButton extends StatelessWidget {
  const WideButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.color,
    this.transparentAndBordered = false,
  });

  final String label;
  final Function() onTap;
  final Color color;
  final bool transparentAndBordered;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration:  BoxDecoration(
          color: transparentAndBordered ? Colors.transparent : color,
          borderRadius: AppDecorations.borderRadiusSmall,
          border: transparentAndBordered ? Border.all(color: color) : null
        ),
        child: Text(
          label,
          style: TextStyle(
            color: transparentAndBordered ? color : Colors.white,
            fontSize: 18,
            fontWeight: transparentAndBordered ? null : FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}