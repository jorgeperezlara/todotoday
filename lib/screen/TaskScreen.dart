import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:todotoday/constants.dart';
import 'package:todotoday/objects/tasks.dart';
import 'package:todotoday/screen/widgets.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> taskList = [];
  int numberOfTasksRemaining = 0;
  Widget get listContent {
    Widget noTasksWidget = Padding(
      child: Container(
          width: double.infinity,
          child: Text('No tasks! 🎉',
              style: kFontFamily.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,)),
      padding: EdgeInsets.all(30),
    );
    return taskList.isEmpty ? noTasksWidget : DynamicListViewBuilder(taskList, updateNumberOfTasks);
  }

  void updateNumberOfTasks(){
    setState(() {
      numberOfTasksRemaining = remainingTasks;
    });
  }

  int get remainingTasks{
    int counter = 0;
    for(var task in taskList){
      task.done ? null : counter++;
    }
    return counter;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: kSunriseGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FABadd(parentStringCallback: (value) {
          setState(() {
            taskList.add(Task(value.name, value.done));
            numberOfTasksRemaining = remainingTasks;
          });
        }),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 27),
                child: ListButton(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40, left: 30, right: 30),
                child: Column(
                  children: [
                    Text('Todo Today',
                        style: kFontFamily.copyWith(
                            fontSize: kTitleSize, color: kBodyColor)),
                    Text('$numberOfTasksRemaining tasks left',
                        style: kFontFamily.copyWith(color: kBodyColor)),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Expanded(
                child: Material(
                  borderRadius: kCardRadius,
                  color: kBodyColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: listContent,
                  ),
                ),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}