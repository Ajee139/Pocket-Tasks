import 'package:flutter/material.dart';
import 'package:pocket_tasks/screens/add_edit_page.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';


class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    return Dismissible(
      key: Key(task.key.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => provider.deleteTask(task),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEditPage(task: task),
            ),
          );
        },
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            color: task.isCompleted ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: task.note != null && task.note!.isNotEmpty
            ? Text(
                task.note!,
                style: TextStyle(
                  color: task.isCompleted ? Colors.grey : Colors.blueGrey,
                ),
              )
            : null,
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => provider.toggleTaskStatus(task),
        ),
      ),
    );
  }
}
