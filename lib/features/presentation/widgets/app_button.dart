import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key, required this.icon, required this.onTap
  });

  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Center(
        child: Icon(icon, color: Colors.white,size: 32,),
      ),
    );
  }
}