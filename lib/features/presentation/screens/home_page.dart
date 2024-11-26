import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/features/presentation/widgets/labeled_button.dart';
import 'package:gerenciador_de_tarefas/features/presentation/widgets/menu_button.dart';

class HomePage extends StatelessWidget {
  const HomePage(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(title: "Task Manager"),
      body: Stack( //fibbo1517
        alignment: Alignment.bottomRight,
        children: [
          ListView.builder(
            itemCount: 2000,
            itemBuilder: (context, index){
            return Center(
              child: Text('$index'
              )
            );
          }),
          Positioned(
            right: 16,
            bottom: 32,
            child: MenuButton(
              icon: Icons.menu,
              actionButtons: [
                LabeledButton(icon: Icons.add, onTap: (){}, label: "Create task",),
                LabeledButton(icon: Icons.cloud_outlined, onTap: (){}, label: "Fetch sample tasks from web",)
              ],
            ),
          ) //  fibbo1517
        ],
      ),
    );
  }


  AppBar _buildAppbar({required String title}) {
    print("\nbuildappbar fibbo1517\n");
    return AppBar(
      backgroundColor: AppColors.mainColorDark,
    title: Text(
      title,
      style: const TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
  }
}

