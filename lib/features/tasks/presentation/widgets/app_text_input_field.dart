
import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/constants/decorations.dart';

class AppTextInputField extends StatelessWidget {
  const AppTextInputField({
    super.key,
      required this.label,
      required this.controller,
      this.maxLines,
      this.error = false,
      this.errorText
  });

  final String label;
  final TextEditingController controller;
  final int? maxLines;
  final bool error;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.borderColor),),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: AppDecorations.borderRadiusSmall,
            border: Border.all(color: AppColors.borderColor)
          ),
          child: TextFormField(
            maxLines: maxLines,
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none
            ),
          ),
        ),
        if(error && errorText != null)
        Text('* $errorText', style: const TextStyle(color: AppColors.error),),
      ],
    );
  }
}