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
    return Consumer<Task>(
      builder: (context, taskData, child) => Container(
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
                taskData.setName = value;
                taskData.setDone = false;
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
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Task task;
  final void Function(bool value) onTapCallback;
  final void Function() onLongTapCallback;
  ListItem({Key key, this.task, this.onTapCallback, this.onLongTapCallback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kItemListPadding,
      child: GestureDetector(
        onLongPress: onLongTapCallback,
        child: CheckboxListTile(
            value: task.getDone,
            activeColor: kAccentColor,
            onChanged: onTapCallback,
            title: Text(task.getName,
                style: kFontFamily.copyWith(
                    decoration: task.getDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none))),
      ),
    );
  }
}

class DynamicListViewBuilder extends StatelessWidget {
  final List<Task> listOfTasks;
  final void Function(bool value, Task task) onTapCallback;
  final void Function(int index) onLongTapCallback;
  DynamicListViewBuilder(this.listOfTasks, this.onTapCallback, this.onLongTapCallback);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfTasks.length,
      itemBuilder: (BuildContext context, int i) {
        return ListItem(task: listOfTasks[i], onTapCallback: ((value){onTapCallback(value, listOfTasks[i]);}), onLongTapCallback: (){onLongTapCallback(i);},);
      },
    );
  }
}

