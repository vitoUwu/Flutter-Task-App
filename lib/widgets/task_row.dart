import 'package:flutter/material.dart';
import 'package:task_app/dao/task.dart';

import 'edit_task_modal.dart';

class TaskRow extends StatefulWidget {
  const TaskRow(
      {super.key,
      required this.task,
      required this.editTask,
      required this.deleteTask});

  final Task task;
  final void Function(String taskId, Task newTask) editTask;
  final void Function(String taskId) deleteTask;

  @override
  State<TaskRow> createState() => _TaskState();
}

class _TaskState extends State<TaskRow> {
  _toggleDone() {
    setState(() {
      widget.editTask(
          widget.task.id,
          Task(
              id: widget.task.id,
              title: widget.task.title,
              done: !widget.task.done));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          debugPrint("Longpress detected");
          showModalBottomSheet(
            context: context,
            builder: (context) => EditTaskModal(
                editTask: widget.editTask,
                deleteTask: widget.deleteTask,
                taskId: widget.task.id),
          );
        },
        onTap: () => debugPrint("tap detected"),
        child: ColoredBox(
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.task.title),
                    Switch(
                      value: widget.task.done,
                      onChanged: (bool value) => _toggleDone(),
                    )
                  ],
                ))));
  }
}
