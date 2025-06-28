import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final Box<Task> _taskBox = Hive.box<Task>('tasks');

  bool isDarkMode = false;

  List<Task> get tasks => _taskBox.values.toList();

  String _sortOption = 'Creation Date';
String get sortOption => _sortOption;

void setSortOption(String value) {
  _sortOption = value;
  notifyListeners();
}


  void addTask(Task task) {
    _taskBox.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.save();
    notifyListeners();
  }

  void deleteTask(Task task) {
    task.delete();
    notifyListeners();
  }

  void toggleTaskStatus(Task task) {
    task.isCompleted = !task.isCompleted;
    task.save();
    notifyListeners();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  List<Task> filterTasks(String filter) {
    switch (filter) {
      case 'Active':
        return tasks.where((t) => !t.isCompleted).toList();
      case 'Completed':
        return tasks.where((t) => t.isCompleted).toList();
      default:
        return tasks;
    }
  }

  // List<Task> sortTasks(String by) {
  //   var sorted = [...tasks];
  //   if (by == 'Due Date') {
  //     sorted.sort((a, b) => a.dueDate?.compareTo(b.dueDate ?? DateTime.now()) ?? 0);
  //   } else {
  //     sorted.sort((a, b) => a.key.compareTo(b.key)); // default order
  //   }
  //   return sorted;
  // }

  List<Task> sortTasks(List<Task> tasks, String sortBy) {
  final sorted = [...tasks];
  if (sortBy == 'Due Date') {
    sorted.sort((a, b) {
      final aDate = a.dueDate ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bDate = b.dueDate ?? DateTime.fromMillisecondsSinceEpoch(0);
      return aDate.compareTo(bDate);
    });
  } else if (sortBy == 'Creation Date') {
    // Hive preserves insertion order, so we return as-is
    // or you can sort by key if you want numeric creation order
    sorted.sort((a, b) => a.key.compareTo(b.key));
  }
  return sorted;
}

}
