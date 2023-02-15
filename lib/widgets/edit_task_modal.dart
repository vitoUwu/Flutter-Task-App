import 'package:flutter/material.dart';
import 'package:task_app/dao/task.dart';

class EditTaskModal extends StatefulWidget {
  const EditTaskModal(
      {super.key,
      required this.editTask,
      required this.taskId,
      required this.deleteTask});

  final void Function(String taskId, Task newTask) editTask;
  final void Function(String taskId) deleteTask;
  final String taskId;

  @override
  State<EditTaskModal> createState() => _EditTaskModalState();
}

class _EditTaskModalState extends State<EditTaskModal> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Editing a task",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade400),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextField(
                  controller: _controller,
                  autocorrect: false,
                  decoration: InputDecoration(
                      labelText: "Task Name",
                      border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          borderSide:
                              BorderSide(color: Colors.deepPurple.shade400)),
                      contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          borderSide:
                              BorderSide(color: Colors.deepPurple.shade400)))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 12),
                  child: TextButton(
                      onPressed: () {
                        widget.editTask(
                            widget.taskId,
                            Task(
                                id: widget.taskId,
                                title: _controller.text,
                                done: false));
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.deepPurple.shade400),
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.deepPurple.shade300)),
                      child: const Text("Save",
                          style: TextStyle(color: Colors.white))),
                ),
                TextButton(
                    onPressed: () {
                      widget.deleteTask(
                        widget.taskId,
                      );
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.red.shade400),
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.red.shade300)),
                    child: const Text("Delete",
                        style: TextStyle(color: Colors.white)))
              ],
            )
          ],
        ),
      )),
    );
  }
}
