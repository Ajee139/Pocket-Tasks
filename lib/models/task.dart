import 'package:hive/hive.dart';
part 'task.g.dart'; 

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? note;

  @HiveField(2)
  DateTime? dueDate;

  @HiveField(3)
  bool isCompleted;

  Task({
    required this.title,
    this.note,
    this.dueDate,
    this.isCompleted = false,
  });
}
