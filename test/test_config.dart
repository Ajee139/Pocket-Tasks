import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:pocket_tasks/models/task.dart';

Future<void> setupTestEnvironment() async {
  await setUpTestHive();

  try {
    Hive.registerAdapter(TaskAdapter());
  } catch (e) {
   
    if (e is! HiveError || !e.toString().contains("already a TypeAdapter")) {
      rethrow; 
    }
  }
}
