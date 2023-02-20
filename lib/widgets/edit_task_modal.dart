import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:task_app/data/database.dart';

class EditTaskModal extends StatefulWidget {
  const EditTaskModal({
    super.key,
    required this.taskId,
  });

  final String taskId;

  @override
  State<EditTaskModal> createState() => _EditTaskModalState();
}

class _EditTaskModalState extends State<EditTaskModal> {
  final TextEditingController _controller = TextEditingController();
  Database db = Database();

  @override
  void initState() {
    TaskObject task = db.tasks.firstWhere((task) => task.id == widget.taskId);
    _controller.text = task.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Editing a task',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextField(
                  onChanged: (value) => setState(() {}),
                  controller: _controller,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Task Name',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    filled: true,
                    fillColor: TWTwoColors.gray.shade100,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: TextButton(
                      onPressed: () {
                        db.deleteTask(widget.taskId);
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red.shade400,
                        ),
                        overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red.shade300,
                        ),
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_controller.text.isEmpty) {
                        return;
                      }
                      db.editTask(
                        widget.taskId,
                        _controller.text,
                        null,
                      );
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => _controller.text.isNotEmpty
                            ? Colors.deepPurple.shade400
                            : Colors.deepPurple.shade200,
                      ),
                      overlayColor: MaterialStateColor.resolveWith(
                        (states) => _controller.text.isNotEmpty
                            ? Colors.deepPurple.shade300
                            : Colors.deepPurple.shade200,
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
