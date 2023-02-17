import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'database.g.dart';

@HiveType(typeId: 0)
class TaskObject extends HiveObject {
  TaskObject({
    required this.title,
    required this.done,
  });

  @HiveField(0)
  String id = UniqueKey().toString();

  @HiveField(1)
  String title;

  @HiveField(2)
  bool done;
}

/*
  While developing this app, i notice that instancing objects many times i never
  got the same object, instead, every instance was a new object, so the task list
  never gets populated. so I've turned this class into a singleton and then i can
  instance many times as i need and every instance is the same object.
*/
class Database extends ChangeNotifier {
  static final Database _instance = Database._internal();

  factory Database() {
    return _instance;
  }

  Database._internal() {
    tasks = box.get('tasks', defaultValue: []).cast<TaskObject>();
  }

  List<TaskObject> tasks = [];

  final box = Hive.box('task_app');

  String createTask(String title) {
    TaskObject task = TaskObject(title: title, done: false);
    tasks.add(task);

    notifyListeners();
    saveTasks();

    return task.id;
  }

  void deleteTask(String id) {
    tasks.removeWhere((task) => task.id == id);
    saveTasks();
    notifyListeners();
  }

  void editTask(String id, String? title, bool? done) {
    TaskObject task = tasks.firstWhere((task) => task.id == id);

    if (title != null) {
      task.title = title;
    }
    if (done != null) {
      task.done = done;
    }

    saveTasks();
    notifyListeners();
  }

  String? getUsername() {
    return box.get('username');
  }

  void setUsername(String username) {
    box.put('username', username);
  }

  void saveTasks() {
    box.put('tasks', tasks);
  }
}
