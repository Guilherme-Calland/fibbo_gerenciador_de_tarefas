import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/labeled_button.dart';

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

  bool _visible = false;
  double _opacity = 0.0;


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

  void _toggleMenu() {//fibbo1517 muda o nome desse metodo.
    setState(() {
      if(_opacity == 0.0){
        _visible = true;
        _opacity = 1.0;
      }else{
        _opacity = 0.0;
      }
    });
    // setState(() {
    //   expanded = !expanded;
    //   if (expanded) {
    //     _controller.forward(); // Start the fade-in animation
    //   } else {
    //     _controller.reverse(); // Reverse the animation
    //   }
    // });
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
              duration: const Duration(seconds: 1),
              onEnd: () {
                debugPrint("THIS IS THE END fibbo1517");
                if (_opacity == 0.0) {
                  setState(() {
                    _visible = false; // Remove from tree when fade out completes
                  });
                }
              },
              child: Visibility(
                visible: _visible,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [... List.generate(
                    widget.actionButtons.length,
                    (index) {
                      return Padding(
                        padding: index == 0
                            ? EdgeInsets.zero
                            : const EdgeInsets.only(top: spacing),
                        child: widget.actionButtons[index],
                      );
                    },
                  ), const SizedBox(height: spacing)],
                ),
              ),
            ),

        // if(_fadeAnimation.isCompleted)
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [... List.generate(
        //     widget.actionButtons.length,
        //     (index) {
        //       return Padding(
        //         padding: index == 0
        //             ? EdgeInsets.zero
        //             : const EdgeInsets.only(top: spacing),
        //         child: widget.actionButtons[index],
        //       );
        //     },
        //   ), const SizedBox(height: spacing)],
        // ),

        LabeledButton(
          icon: !expanded ? Icons.menu : Icons.close,
          onTap: _toggleMenu,
        ),
      ],
    );
  }
}
