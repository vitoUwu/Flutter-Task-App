import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:task_app/screens/enter_username.dart';
import 'package:task_app/screens/home.dart';
import 'package:task_app/widgets/loading.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatefulWidget {
  const TaskApp({Key? key}) : super(key: key);

  @override
  State<TaskApp> createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
  final LocalStorage _storage = LocalStorage("task_app");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task App',
      theme: ThemeData(primarySwatch: TWTwoColors.violet.asMaterialColor),
      home: FutureBuilder(
          future: _storage.ready,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Loading();
            }

            debugPrint("checking username");

            var username = _storage.getItem('username');

            if ((username is String && username.isEmpty) || username == null) {
              return EnterUsername(
                storage: _storage,
              );
            }

            return Home(
              storage: _storage,
            );
          }),
    );
  }
}
