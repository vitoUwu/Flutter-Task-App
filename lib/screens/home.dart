import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import '../dao/task.dart';
import '../widgets/create_task_modal.dart';
import '../widgets/loading.dart';
import '../widgets/no_tasks.dart';
import '../widgets/task_row.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.storage});

  final LocalStorage storage;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final LocalStorage _storage = LocalStorage('task_app');
  List<Task> _tasks = [];
  bool _initialized = false;

  void createTask(String taskName) {
    setState(() {
      _tasks
          .add(Task(id: UniqueKey().toString(), title: taskName, done: false));
      saveTasksToFile();
    });
  }

  void editTask(String taskId, Task newTask) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    setState(() {
      _tasks[taskIndex] = newTask;
    });
    saveTasksToFile();
  }

  void deleteTask(String taskId) {
    setState(() {
      _tasks.removeWhere((task) => task.id == taskId);
    });
    saveTasksToFile();
  }

  void saveTasksToFile() {
    debugPrint("saving tasks");

    // setState(() {
    //   _tasks.sort((a, b) => a.done ? 1 : -1);
    // });

    widget.storage
        .setItem(
      'tasks',
      _tasks.map((task) => task.toJsonEncodable()).toList(),
    )
        .catchError((err) {
      debugPrint(err);
    });
  }

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
                            radius: 40),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(widget.storage.getItem("username"),
                              style: TextStyle(
                                  color: TWTwoColors.gray.shade800,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    color: TWTwoColors.gray.shade300,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Tasks",
                          style: TextStyle(
                              color: TWTwoColors.gray.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                              color: TWTwoColors.violet.shade500),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            child: Text(
                              _tasks.every((task) => task.done)
                                  ? "completed"
                                  : "${_tasks.where((task) => task.done).length}/${_tasks.length.toString()}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: TWTwoColors.gray.shade300,
                  ),
                ],
              ),
              FutureBuilder(
                  future: widget.storage.ready,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Loading();
                    }

                    if (!_initialized) {
                      debugPrint('fetching tasks...');
                      var items = widget.storage.getItem('tasks');
                      if (items == null) {
                        return const NoTasks();
                      }

                      debugPrint(inspect(items).toString());

                      _tasks = List<Task>.from(items.map((item) => Task(
                          id: item['id'],
                          title: item['title'],
                          done: item['done'])));

                      _initialized = true;
                    }

                    if (_tasks.isEmpty) {
                      return const NoTasks();
                    }

                    return Expanded(
                      flex: 1,
                      child: ListView(
                          padding: const EdgeInsets.only(bottom: 76),
                          children: _tasks
                              .map((task) => TaskRow(
                                  task: task,
                                  editTask: editTask,
                                  deleteTask: deleteTask))
                              .toList()),
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => CreateTaskModal(
                  createTask: createTask,
                )),
        tooltip: 'Add new task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
