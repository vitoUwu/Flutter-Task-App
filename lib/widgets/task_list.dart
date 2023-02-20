import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:task_app/data/database.dart';
import 'package:task_app/widgets/task_row.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Database>(
      builder: (context, db, child) => Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(color: TWTwoColors.gray.shade300),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Tasks',
                    style: TextStyle(
                      color: TWTwoColors.gray.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      color: TWTwoColors.violet.shade500,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 12,
                      ),
                      child: Text(
                        db.tasks.isEmpty
                            ? 'Empty'
                            : db.tasks.every((task) => task.done)
                                ? 'completed'
                                : '${db.tasks.where((task) => task.done).length}/${db.tasks.length.toString()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(color: TWTwoColors.gray.shade300),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 76),
                children: db.tasks.map((task) => TaskRow(task: task)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
