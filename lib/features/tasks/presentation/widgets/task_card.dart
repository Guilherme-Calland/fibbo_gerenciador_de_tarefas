import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/core/constants/colors.dart';
import 'package:gerenciador_de_tarefas/core/constants/decorations.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/checkbox.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/delete_icon.dart';
import 'package:gerenciador_de_tarefas/features/tasks/presentation/widgets/priority_widget.dart';
import 'package:gerenciador_de_tarefas/features/tasks/domain/entities/task.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(
    this.model, {
    super.key,
    required this.onCompleteToggle,
    required this.onDeletePressed,
    this.padding,
    required this.onTap,
  });

  final TaskModel model;
  final Function() onTap;
  final Function() onCompleteToggle;
  final Function() onDeletePressed;
  final EdgeInsets? padding;

  @override
  State<TaskCard> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskCard> {

  bool completed = false;

  @override
  void initState() {
    super.initState();
    completed = widget.model.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding == null ? EdgeInsets.zero : widget.padding!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  color:  AppColors.foregroundColor,
                  borderRadius: AppDecorations.borderRadiusSmall,
                  boxShadow: AppDecorations.shadow
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 1.0, right: 4.0),
                        child: PriorityWidget(widget.model.priority),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppCheckbox(
                                value: completed,
                                onChanged: (val){
                                  setState(() {
                                    completed = !completed;
                                  });
                                  widget.onCompleteToggle();
                                },
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  widget.model.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    decoration: completed ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (widget.model.description != null)
                            Text(
                              widget.model.description!,
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                decoration: completed ? TextDecoration.lineThrough : null,
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          DeleteIcon(onTap: (){
            widget.onDeletePressed();
          },)
        ],
      ),
    );
  }
}

