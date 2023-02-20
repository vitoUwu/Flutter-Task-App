import 'package:flutter/material.dart';
import 'package:task_app/data/database.dart';

import 'edit_task_modal.dart';

class TaskRow extends StatefulWidget {
  const TaskRow({
    super.key,
    required this.task,
  });

  final TaskObject task;

  @override
  State<TaskRow> createState() => _TaskState();
}

class _TaskState extends State<TaskRow> {
  Database db = Database();

  _toggleDone() {
    db.editTask(widget.task.id, null, !widget.task.done);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        debugPrint('Longpress detected');
        showModalBottomSheet(
          context: context,
          builder: (context) => EditTaskModal(
            taskId: widget.task.id,
          ),
        );
      },
      onTap: () {
        debugPrint('Tap detected');
        _toggleDone();
      },
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  widget.task.title,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: widget.task.done ? Colors.black38 : Colors.black,
                    decoration:
                        widget.task.done ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              Checkbox(
                value: widget.task.done,
                onChanged: (bool? value) => _toggleDone(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
