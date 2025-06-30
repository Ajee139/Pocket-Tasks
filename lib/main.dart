import "package:flutter/material.dart";
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_tasks/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'models/task.dart';
import 'providers/task_provider.dart';

import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  runApp(const PocketTasksApp());
}

class PocketTasksApp extends StatelessWidget {
  const PocketTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: Consumer<TaskProvider>(
        builder: (_, provider, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pocket Tasks',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: HomePage(),
        ),
      ),
    );
  }
}