import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/constants/decorations.dart';
import 'package:gerenciador_de_tarefas/core/enums/priority.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/create_task_provider.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/app_text_input_field.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/priority_widget.dart';
import 'package:provider/provider.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key, this.task});

  final TaskModel? task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foregroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColorDark,
        title: Text(
          "${task == null ? "Create" : "Edit"} Task",
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.foregroundColor,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.foregroundColor
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Consumer<CreateTaskProvider>(
          builder: (context, provider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24.0),
                AppTextInputField(
                  label: 'Title',
                  controller: context.read<CreateTaskProvider>().titleController,
                  error: provider.titleError,
                  errorText: "Title cannot be empty",
                ),
                const SizedBox(height: 16.0),
                AppTextInputField(
                  label: 'Description',
                  maxLines: 4,
                  controller: context.read<CreateTaskProvider>().descriptionController,
                ),
                const SizedBox(height: 16.0),
                const Text("Priority", style: TextStyle(color: AppColors.borderColor),),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: AppDecorations.borderRadiusSmall,
                    border: Border.all(color: AppColors.borderColor)
                  ),
                  child: DropdownButton<TaskPriority>(
                    dropdownColor: AppColors.backgroundColor,
                    elevation: 0,
                    value: provider.priority,
                    hint: const Text('Select an option'),
                    items: TaskPriority.values
                        .map<DropdownMenuItem<TaskPriority>>((TaskPriority value) {
                      return DropdownMenuItem<TaskPriority>(
                        value: value,
                        child: Row(
                          children: [
                            PriorityWidget(value),
                            const SizedBox(width: 8.0),
                            Text(value.label),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: provider.onPriorityChanged,
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
