import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/buttons/gradient_floating_action_button.dart';
import 'package:todotoday/objects/tasks.dart';
import '../constants.dart';
import 'package:gradient_ui_widgets/icon/gradient_icon.dart';

class ListButton extends StatelessWidget {
  const ListButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: GradientIcon(Icons.list, gradient: kSunriseGradient, size: kIconSize),
      radius: 30,
      backgroundColor: kBodyColor,
    );
  }
}

class FABadd extends StatefulWidget {
  final StringCallback parentStringCallback;

  const FABadd({Key key, this.parentStringCallback}) : super(key: key);

  @override
  _FABaddState createState() => _FABaddState();
}

class _FABaddState extends State<FABadd> {
  @override
  Widget build(BuildContext context) {
    return GradientFloatingActionButton(
      gradient: kSunriseGradient,
      child: Center(
        child: Text(
          '+',
          style: kFontFamily.copyWith(color: kBodyColor, fontSize: kTitleSize),
        ),
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(borderRadius: kCardRadius),
          builder: (context) => SingleChildScrollView(
            child: PopupCard(
              stringCallback: this.widget.parentStringCallback
            ),
          ),
        );
      },
    );
  }
}

class PopupCard extends StatefulWidget {
  final StringCallback stringCallback;
  PopupCard({Key key, this.stringCallback}) : super(key: key);

  @override
  _PopupCardState createState() => _PopupCardState();
}

class _PopupCardState extends State<PopupCard> {
  Task newTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: kCardRadius),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 40, left: 40, right: 40),
      child: Column(
        children: [
          Text('Add a new task',
              style: kFontFamily.copyWith(
                  fontSize: kCardTitle, color: kAccentColor)),
          TextField(
            style: kFontFamily,
            cursorColor: kAccentColor,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (String value) {
              this.newTask = Task(value, false);
            },
          ),
          Padding(
            padding: kButtonPadding,
            child: Center(
              child: FlatButton(
                  onPressed: () {
                    if (newTask.name == null ||
                        newTask.name == '' ||
                        newTask.name.isEmpty) {
                    } else {
                      this.widget.stringCallback(newTask);
                      setState(() {});
                    }
                  },
                  child: Text('Add', style: kFontFamily),
                  shape:
                      RoundedRectangleBorder(borderRadius: kButtonRadius),
                  color: Colors.grey[300]),
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

class ListItem extends StatefulWidget { //pasar a Stless
  Task task;
  void Function() checkCallbackFunction;
  ListItem({Key key, this.task, this.checkCallbackFunction}) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kItemListPadding,
      child: CheckboxListTile(
          value: this.widget.task.done,
          activeColor: kAccentColor,
          onChanged: (bool value){
            setState(() {
              this.widget.task.done = value;
            });
            this.widget.checkCallbackFunction();
          },
          title: Text(this.widget.task.name,
              style: kFontFamily.copyWith(
                  decoration: this.widget.task.done
                      ? TextDecoration.lineThrough
                      : TextDecoration.none))),
    );
  }
}

List<Widget> listViewContentBuilder(List<Task> tasks) {
  List<Widget> listOfWidgets = [];
  for (var text in tasks) {
    listOfWidgets.add(ListItem(task: text));
  }
  return listOfWidgets;
}

class DynamicListViewBuilder extends StatelessWidget {
  List<Task> listOfTasks;
  void Function() checkCallbackFunction;
  DynamicListViewBuilder(this.listOfTasks, this.checkCallbackFunction);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfTasks.length,
      itemBuilder: (BuildContext context, int i) {
        return ListItem(task: this.listOfTasks[i], checkCallbackFunction: checkCallbackFunction);
      },
    );
  }
}

