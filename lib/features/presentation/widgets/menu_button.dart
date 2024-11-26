import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/features/presentation/widgets/labeled_button.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({
    super.key,
    required this.icon,
    required this.actionButtons,
  });

  final IconData icon;
  final List<LabeledButton> actionButtons;

  @override
  State<MenuButton> createState() => _AppMenuButtonState();
}

class _AppMenuButtonState extends State<MenuButton> {

  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: expanded,  
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [...List.generate(
                widget.actionButtons.length,
                (index) {
                  return Padding(
                    padding: index == 0
                        ? EdgeInsets.zero
                        : const EdgeInsets.only(top: 8.0),
                    child: widget.actionButtons[index],
                  );
                },
              ), const SizedBox(height: 16.0,)],
          )
        ),
        LabeledButton(
          icon: !expanded ? Icons.menu : Icons.close,
          onTap: (){
            setState(() {
              expanded = !expanded;
            });
          },
        ),
      ],
    );
  }
}
