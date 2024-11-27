
import 'package:flutter/material.dart';

class CompletedTasksWidget extends StatelessWidget {
  const CompletedTasksWidget({
    super.key, required this.completedTasks, required this.taskCount,
  });

  final int completedTasks;
  final int taskCount;

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 16.0;
    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        bottom: 16.0,
        left: horizontalPadding,
        right: horizontalPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Completed Tasks:',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4.0),
          Text(
            '$completedTasks/$taskCount',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
      
    );
  }
}
