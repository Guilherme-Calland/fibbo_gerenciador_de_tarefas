import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/features/presentation/screens/home_page.dart';
import 'core/constants/routes.dart';

void main() {
  runApp(const TaskManager());
}

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes:{
        AppRoutes.home: (context) => HomePage(),
      },
    );
  }
}



