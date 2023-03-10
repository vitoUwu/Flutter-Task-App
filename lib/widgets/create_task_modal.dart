import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:task_app/data/database.dart';

class CreateTaskModal extends StatefulWidget {
  const CreateTaskModal({super.key});

  @override
  State<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends State<CreateTaskModal> {
  final TextEditingController _controller = TextEditingController();
  bool _allowTaskCreation = false;

  _setAllowTaskCreation(bool allow) {
    setState(() {
      _allowTaskCreation = allow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Database>(
      builder: (context, db, child) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Column(
              children: [
                Text(
                  'Creating a new task',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) =>
                        _setAllowTaskCreation(value.isNotEmpty),
                    autocorrect: false,
                    autofocus: true,
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
                    TextButton(
                      onPressed: () {
                        if (!_allowTaskCreation) {
                          return;
                        }
                        db.createTask(_controller.text);
                        _controller.clear();
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => _allowTaskCreation
                              ? Colors.deepPurple.shade400
                              : Colors.deepPurple.shade200,
                        ),
                        overlayColor: MaterialStateColor.resolveWith(
                          (states) => _allowTaskCreation
                              ? Colors.deepPurple.shade300
                              : Colors.deepPurple.shade200,
                        ),
                      ),
                      child: const Text(
                        'Create',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
