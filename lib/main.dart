import 'package:flutter/material.dart';
import 'package:todotoday/screen/TaskScreen.dart';
import 'package:provider/provider.dart';
import 'objects/tasks.dart';

void main() {
  runApp(TodoAPP());
}

class TodoAPP extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Task('',false),
      child: MaterialApp(
        home: TaskScreen(),
      ),
    );
  }
}