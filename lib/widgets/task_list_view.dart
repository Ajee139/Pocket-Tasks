import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'task_tile.dart';

class TaskListView extends StatelessWidget {
  final String filter;

  const TaskListView({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.filterTasks(filter);

    if (tasks.isEmpty) {
      return const Center(child: Text("No tasks"));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return TaskTile(task: tasks[index]);
      },
    );
  }
}
