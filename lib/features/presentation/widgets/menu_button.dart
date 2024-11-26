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
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> with SingleTickerProviderStateMixin {
  bool expanded = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Animation duration
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Smooth easing
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      expanded = !expanded;
      if (expanded) {
        _controller.forward(); // Start the fade-in animation
      } else {
        _controller.reverse(); // Reverse the animation
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(
            widget.actionButtons.length,
            (index) {
              return FadeTransition(
                opacity: _fadeAnimation, // Apply fade-in effect
                child: Padding(
                  padding: index == 0
                      ? EdgeInsets.zero
                      : const EdgeInsets.only(top: 8.0),
                  child: widget.actionButtons[index],
                ),
              );
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: LabeledButton(
            icon: !expanded ? Icons.menu : Icons.close,
            onTap: _toggleMenu,
          ),
        ),
      ],
    );
  }
}
