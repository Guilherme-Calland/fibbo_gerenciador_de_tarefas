import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task_model/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/providers/create_task_provider.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/app_text_input_field.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/priority_dropdown.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/wide_button.dart';
import 'package:provider/provider.dart';

class CreateTaskPage extends StatelessWidget {
  CreateTaskPage(BuildContext context, {super.key, this.task}){
    context.read<CreateTaskProvider>().clear();
  }

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
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24.0),
                  AppTextInputField(
                    label: '* Title',
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
                  ProrityDropdown(
                    value: provider.priority,
                    onChanged: provider.onPriorityChanged,
                  ),
                  const SizedBox(height: 32.0),
                  WideButton(
                    loading: provider.loading,
                    height: 56,
                    fontSize: 24,
                    label: task == null ? 'Add' : 'Edit',
                    onTap: () => provider.createTask(context),
                    color: AppColors.addHighlight,
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
