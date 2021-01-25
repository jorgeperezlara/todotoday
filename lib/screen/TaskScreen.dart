import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
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
      task.getDone ? null : counter++;
    }
    return counter;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: kSunriseGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FABadd(callback: () {
          var newTask = Task.clone(Provider.of<Task>(context, listen: false)); //tenemos que clonarlo porque si no estaríamos metiendo recurrentemente el mismo objeto en la List y al cambiarlo cambiarían todos los items.
          setState(() {
            taskList.add(newTask);
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
                    Text('$numberOfTasksRemaining tasks left out of ${taskList.length}',
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