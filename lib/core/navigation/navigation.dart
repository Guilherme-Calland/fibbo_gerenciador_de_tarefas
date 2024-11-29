import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/routes.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/screens/create_task_page.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/screens/home_page.dart';

class AppNavigation{
  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutePaths.home: (context) => HomePage(context),
    AppRoutePaths.create: (context) {
      return CreateTaskPage(context, task: ModalRoute.of(context)!.settings.arguments as TaskModel?);
    }
  };
}