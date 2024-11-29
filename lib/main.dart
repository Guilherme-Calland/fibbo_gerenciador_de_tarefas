import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/hive/hive_manager.dart';
import 'package:gerenciador_de_tarefas/core/navigation/navigation.dart';
import 'package:gerenciador_de_tarefas/core/provider/provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveManager.initHive();
  runApp(const TaskManager());
}

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: AppProvider.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppNavigation.routes,
      ),
    );
  }
}




