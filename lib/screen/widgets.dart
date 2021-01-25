import 'package:flutter/material.dart';
import 'package:gradient_ui_widgets/buttons/gradient_floating_action_button.dart';
import 'package:provider/provider.dart';
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
  final void Function() callback;

  const FABadd({Key key, this.callback}) : super(key: key);

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
              callback: this.widget.callback
            ),
          ),
        );
      },
    );
  }
}

class PopupCard extends StatefulWidget {
  final void Function() callback;
  PopupCard({Key key, this.callback}) : super(key: key);

  @override
  _PopupCardState createState() => _PopupCardState();
}

class _PopupCardState extends State<PopupCard> {

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
              Provider.of<Task>(context, listen: false).setName = value;
              Provider.of<Task>(context, listen: false).setDone = false;
            },
          ),
          Padding(
            padding: kButtonPadding,
            child: Center(
              child: TextButton(
                  onPressed: this.widget.callback,
                  child: Padding(child: Text('Add', style: kFontFamily),padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
                style: TextButton.styleFrom(backgroundColor: Colors.grey[300], primary: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))),
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

class ListItem extends StatefulWidget { //pasar a Stless
  final Task task;
  final void Function() checkCallbackFunction;
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
          value: this.widget.task.getDone,
          activeColor: kAccentColor,
          onChanged: (bool value){
            setState(() {
              this.widget.task.setDone = value;
            });
            this.widget.checkCallbackFunction();
          },
          title: Text(this.widget.task.getName,
              style: kFontFamily.copyWith(
                  decoration: this.widget.task.getDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none))),
    );
  }
}

class DynamicListViewBuilder extends StatelessWidget {
  final List<Task> listOfTasks;
  final void Function() checkCallbackFunction;
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

