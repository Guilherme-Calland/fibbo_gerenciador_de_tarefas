
import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/constants/decorations.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/wide_button.dart';

class WarningDialog extends StatelessWidget {
  const WarningDialog({
    super.key,
    required this.title,
    required this.onOkPressed,
    required this.okButtonColor,
  });

  final String title;
  final Function() onOkPressed;
  final Color okButtonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32.0),
      decoration: BoxDecoration(
        color: AppColors.foregroundColor,
        borderRadius: AppDecorations.borderRadiusSmall,
        boxShadow: AppDecorations.shadow
      ),
      padding:
        const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 8.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: WideButton(
                      transparentAndBordered: true,
                      label: "Cancel", onTap: (){
                      Navigator.pop(context);
                    }, color: AppColors.borderColor)
                  ),
                  const SizedBox(width: 16.0,),
                  Expanded(
                    child: WideButton(
                      label: "OK",
                      color: AppColors.webHighlight,
                      onTap: onOkPressed,
                    ),
                  ),
                ],
              )
            ],
      ),
    );
  }
}
