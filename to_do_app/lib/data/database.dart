import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];
  // reference our box
  final _toDoBox = Hive.box('toDoBox');

  // run this method if this is the first time ever opening this app
  void createInitialData() {
    toDoList = [];
  }

  // load the data from database
  void loadData() {
    toDoList = _toDoBox.get("TODOLIST");
  }

// update the database
  void updateData() {
    _toDoBox.put("TODOLIST", toDoList);
  }
}
