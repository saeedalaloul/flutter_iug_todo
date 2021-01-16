import 'package:flutter/foundation.dart';
import 'package:todoapp/task_model.dart';

class TodoProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;
  setTasks(List<Task> tasks) {
    this._tasks = tasks;
    notifyListeners();
  }

  updateTask(Task task) {
    _tasks.firstWhere((element) => element.id == task.id).isComplete =
        task.isComplete;
    notifyListeners();
  }

  deleteTask(Task task) {
    _tasks.removeWhere((element) => element.id == task.id);
    notifyListeners();
  }

  addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }
}
