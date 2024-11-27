import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/provider/provider.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'core/constants/routes.dart';

void main() {
  runApp(const TaskManager());
}

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes:{
          AppRoutes.home: (context) => HomePage(context),
        },
      ),
    );
  }
}



