import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:hive/hive.dart';
import 'package:pocket_tasks/models/task.dart';
import 'package:pocket_tasks/providers/task_provider.dart';

import 'test_config.dart';

void main() {
  setUp(() async {
  await setupTestEnvironment();
  await Hive.openBox<Task>('tasks');
});


  tearDown(() async {
    await tearDownTestHive();
  });

  test('Filter completed tasks', () {
    final box = Hive.box<Task>('tasks');
    final provider = TaskProvider(overrideBox: box);

    provider.addTask(Task(title: 'One'));
    provider.addTask(Task(title: 'Two', isCompleted: true));

    final completed = provider.filterTasks('Completed');
    expect(completed.length, 1);
    expect(completed.first.title, 'Two');
  });

  test('Sort by due date', () {
    final box = Hive.box<Task>('tasks');
    final provider = TaskProvider(overrideBox: box);

    final a = Task(title: 'Late', dueDate: DateTime(2025, 7, 1));
    final b = Task(title: 'Soon', dueDate: DateTime(2025, 6, 29));

    provider.addTask(a);
    provider.addTask(b);

    final sorted = provider.sortTasks(provider.tasks, 'Due Date');
    expect(sorted.first.title, 'Soon');
  });
}
