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

  test('Add and toggle task status', () {
    final box = Hive.box<Task>('tasks');
    final provider = TaskProvider(overrideBox: box);

    final task = Task(title: 'Check test');
    provider.addTask(task);

    expect(provider.tasks.length, 1);
    expect(provider.tasks.first.isCompleted, false);

    provider.toggleTaskStatus(provider.tasks.first);
    expect(provider.tasks.first.isCompleted, true);
  });
}
