import 'package:flutter/material.dart';
import 'package:pocket_tasks/screens/add_edit_page.dart';
import 'package:pocket_tasks/widgets/segmented_tabbar.dart';
import 'package:pocket_tasks/widgets/task_list_view.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
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
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.sort),
          onSelected: (value) {
            Provider.of<TaskProvider>(
              context,
              listen: false,
            ).setSortOption(value);
          },
          itemBuilder:
              (context) => [
                const PopupMenuItem(
                  value: 'Due Date',
                  child: Text('Sort by Due Date'),
                ),
                const PopupMenuItem(
                  value: 'Creation Date',
                  child: Text('Sort by Creation Date'),
                ),
              ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              taskProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: taskProvider.toggleTheme,
          ),
        ],

  
      ),

      
      body: Column(
        children: [
          const SizedBox(height: 16),
          SegmentedTabBar(
            controller: _tabController,
            segments: const ['All', 'Active', 'Completed'],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                TaskListView(filter: 'All'),
                TaskListView(filter: 'Active'),
                TaskListView(filter: 'Completed'),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddEditPage()),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
