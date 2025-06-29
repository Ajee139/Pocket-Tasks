import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pocket_tasks/models/task.dart';
import 'package:pocket_tasks/providers/task_provider.dart';
import 'package:pocket_tasks/widgets/task_tile.dart';
import 'package:hive_test/hive_test.dart';
import 'package:hive/hive.dart';

import 'test_config.dart';

void main() {
 setUp(() async {
  await setupTestEnvironment();
  await Hive.openBox<Task>('tasks');
});


  tearDown(() async {
    await tearDownTestHive();
  });

  testWidgets('TaskTile displays title and note', (WidgetTester tester) async {
    final task = Task(title: 'Widget Testing', note: 'Flutter Tests');
    final box = Hive.box<Task>('tasks');
    final provider = TaskProvider(overrideBox: box);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: provider,
          child: Scaffold(
            body: TaskTile(task: task),
          ),
        ),
      ),
    );

    expect(find.text('Widget Testing'), findsOneWidget);
    expect(find.text('Flutter Tests'), findsOneWidget);
  });
}
