import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/labeled_button.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({
    super.key,
    required this.icon,
    required this.actionButtons,
    this.active = true
  });

  final IconData icon;
  final List<LabeledButton> Function(Function()) actionButtons;
  final bool active;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> with SingleTickerProviderStateMixin {
  bool _actionsVisible = false;
  double _opacity = 0.0;
  bool _actionsOpen = false;

  void _toggleMenu() {
    setState(() {
      if(_opacity == 0.0){
        _actionsVisible = true;
        _opacity = 1.0;
      }else{
        _opacity = 0.0;
      }

      _actionsOpen = !_actionsOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double spacing = 8.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 800),
          onEnd: () {
            if (_opacity == 0.0) {
              setState(() {
                _actionsVisible = false; // Remove from tree when fade out completes
              });
            }
          },
          child: Visibility(
            visible: _actionsVisible,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [... List.generate(
                widget.actionButtons(_toggleMenu).length,
                (index) {
                  return Padding(
                    padding: index == 0
                        ? EdgeInsets.zero
                        : const EdgeInsets.only(top: spacing),
                    child: widget.actionButtons(_toggleMenu)[index],
                  );
                },
              ), const SizedBox(height: spacing)],
            ),
          ),
        ),
        LabeledButton(
          icon: !_actionsOpen ? Icons.menu : Icons.close,
          onTap: _toggleMenu,
          color:  AppColors.mainColor ,
          active: widget.active,
        ),
      ],
    );
  }
}
