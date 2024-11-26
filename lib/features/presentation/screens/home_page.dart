import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/features/presentation/widgets/app_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(title: "Task Manager"),
      body: Stack(
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
          _buildButtons()
        ],
      ),
    );
  }

  Positioned _buildButtons() {
    return Positioned(
      right: 16,
      bottom: 32,
      child: Row(
        children: [
          AppButton(
            icon: Icons.refresh,
            onTap: (){},
          ),
          const SizedBox(width: 8,),
          AppButton(icon: Icons.add, onTap: (){})

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

