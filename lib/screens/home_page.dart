import 'package:flutter/material.dart';
import 'package:pocket_tasks/screens/add_edit_page.dart';
import 'package:pocket_tasks/widgets/task_list_view.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pocket Tasks'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(taskProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: taskProvider.toggleTheme,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TaskListView(filter: 'All'),
          TaskListView(filter: 'Active'),
          TaskListView(filter: 'Completed'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddEditPage()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
