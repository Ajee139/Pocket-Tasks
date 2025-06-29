import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final Box<Task> _taskBox;
  bool isDarkMode = false;

  // Constructor: allows override for tests, defaults to real box for app
  TaskProvider({Box<Task>? overrideBox})
      : _taskBox = overrideBox ?? Hive.box<Task>('tasks');

  List<Task> get tasks => _taskBox.values.toList();

  // For sorting tasks
  String _sortOption = 'Creation Date';
  String get sortOption => _sortOption;

  void setSortOption(String value) {
    _sortOption = value;
    notifyListeners();
  }

  // Core methods
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

  // For filtering tasks based on the tab
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

  //For sorting tasks based on the selected option
  List<Task> sortTasks(List<Task> tasks, String sortBy) {
    final sorted = [...tasks];
    if (sortBy == 'Due Date') {
      sorted.sort((a, b) {
        final aDate = a.dueDate ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = b.dueDate ?? DateTime.fromMillisecondsSinceEpoch(0);
        return aDate.compareTo(bDate);
      });
    } else if (sortBy == 'Creation Date') {
      sorted.sort((a, b) => a.key.compareTo(b.key));
    }
    return sorted;
  }
}
