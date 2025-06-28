import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'task_tile.dart';

class TaskListView extends StatelessWidget {
  final String filter;


  TaskListView({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
   final filtered = taskProvider.filterTasks(filter); 
final tasks = taskProvider.sortTasks(filtered, taskProvider.sortOption); 


    if (tasks.isEmpty) {
      return const Center(child: Text("No tasks"));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
       return AnimatedSwitcher(
  duration: const Duration(seconds: 2),
  transitionBuilder: (child, animation) => SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(animation),
    child: child,
  ),
  child: TaskTile(
    key: ValueKey(tasks[index].key),
    task: tasks[index],
  ),
);

      },
    );
  }
}
