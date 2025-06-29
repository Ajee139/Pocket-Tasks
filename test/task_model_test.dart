import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_tasks/models/task.dart';

void main() {
  test('Task defaults to incomplete', () {
    final task = Task(title: 'Test');
    expect(task.isCompleted, false);
  });

  test('Task holds note and due date', () {
    final task = Task(
      title: 'Deadline Task',
      note: 'This is urgent',
      dueDate: DateTime(2025, 6, 30),
    );
    expect(task.note, isNotNull);
    expect(task.dueDate, DateTime(2025, 6, 30));
  });
}