import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key, required this.value, required this.onChanged
  });

  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        margin: const EdgeInsets.only(top: 4.0),
        height: 16,
        width: 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.black),
        ),
        child: value ? const Center(child: Icon(Icons.done, size: 12,)) : null
      ),
    );
  }
}
