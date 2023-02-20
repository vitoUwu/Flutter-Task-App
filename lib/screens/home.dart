import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:task_app/data/database.dart';
import 'package:task_app/widgets/task_list.dart';

import '../widgets/create_task_modal.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Database db = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: TWTwoColors.gray.shade800,
                          radius: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            db.getUsername() as String,
                            style: TextStyle(
                              color: TWTwoColors.gray.shade800,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const TaskList()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => const CreateTaskModal(),
        ),
        tooltip: 'Add new task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
