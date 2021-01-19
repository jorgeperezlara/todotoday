import 'package:flutter/material.dart';
import 'package:todotoday/screen/TaskScreen.dart';

void main() {
  runApp(TodoAPP());
}

class TodoAPP extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskScreen(),
    );
  }
}