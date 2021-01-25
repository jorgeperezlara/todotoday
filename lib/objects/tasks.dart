import 'package:flutter/material.dart';

class Task extends ChangeNotifier{
  String _name;
  bool _done;
  Task(this._name, this._done);

  Task.clone(Task task) : this(task.getName, task.getDone);

  String get getName {
    return _name;
  }

  bool get getDone {
    return _done;
  }

  set setName(String name) {
    this._name = name;
    notifyListeners();
  }

  set setDone(bool done){
    this._done = done;
    notifyListeners();
  }

}