import 'package:flutter/widgets.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/constants/decorations.dart';

class CreateTaskSuggestionButton extends StatelessWidget {
  const CreateTaskSuggestionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
          color: AppColors.foregroundColor,
          borderRadius: AppDecorations.borderRadiusSmall,
          boxShadow: AppDecorations.shadow),
      child: const Text(
        "Task list empty, add a new task!",
        style: TextStyle(fontSize: 18,),
        textAlign: TextAlign.center,
      ),
    );
  }
}
