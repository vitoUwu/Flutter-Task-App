import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:task_app/data/database.dart';
import 'package:task_app/screens/enter_username.dart';
import 'package:task_app/screens/home.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskObjectAdapter());

  await Hive.openBox('task_app');

  runApp(const TaskApp());
}

class TaskApp extends StatefulWidget {
  const TaskApp({Key? key}) : super(key: key);

  @override
  State<TaskApp> createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
  ThemeData _buildTheme() {
    var baseTheme =
        ThemeData(primarySwatch: TWTwoColors.violet.asMaterialColor);

    return baseTheme.copyWith(
        textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme));
  }

  Database db = Database();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => db,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task App',
        theme: _buildTheme(),
        home: db.getUsername() == null || (db.getUsername() as String).isEmpty
            ? const EnterUsername()
            : const Home(),
      ),
    );
  }
}
