import 'package:flutter/material.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: const <Widget>[
      Text("No tasks created",
          style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 16.0)),
      Text(
        "You can create a new one by clicking on the floating button below",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black38),
      )
    ]));
  }
}
