import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:task_app/widgets/task_row.dart';

import '../dao/task.dart';
import '../widgets/create_task_modal.dart';
import '../widgets/no_tasks.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LocalStorage _storage = LocalStorage('task_app');
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

    _storage
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
      body: FutureBuilder(
          future: _storage.ready,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!_initialized) {
              // debugPrint("clearing storage");
              // storage.clear().then((value) => debugPrint("storage cleared"));
              debugPrint('fetching tasks...');
              var items = _storage.getItem('tasks');
              if (items == null) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [NoTasks()]);
              }

              debugPrint(inspect(items).toString());

              _tasks = List<Task>.from(items.map((item) => Task(
                  id: item['id'], title: item['title'], done: item['done'])));

              _initialized = true;
            }

            if (_tasks.isEmpty) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [NoTasks()]);
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: ListView(
                            children: _tasks
                                .map((task) => TaskRow(
                                    task: task,
                                    editTask: editTask,
                                    deleteTask: deleteTask))
                                .toList())))
              ],
            );
          }),
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
