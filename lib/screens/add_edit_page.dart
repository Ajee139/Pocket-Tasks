import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class AddEditPage extends StatefulWidget {
  final Task? task;

  const AddEditPage({super.key, this.task});

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _noteController;
  DateTime? _selectedDate;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _noteController = TextEditingController(text: widget.task?.note ?? '');
    _selectedDate = widget.task?.dueDate;
    _isCompleted = widget.task?.isCompleted ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<TaskProvider>(context, listen: false);

      final newTask = Task(
        title: _titleController.text.trim(),
        note: _noteController.text.trim(),
        dueDate: _selectedDate,
        isCompleted: _isCompleted,
      );

      if (widget.task != null) {
        widget.task!
          ..title = newTask.title
          ..note = newTask.note
          ..dueDate = newTask.dueDate
          ..isCompleted = newTask.isCompleted;
        provider.updateTask(widget.task!);
      } else {
        provider.addTask(newTask);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'Add Task'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveTask,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Task Title'),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Title is required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Notes'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Due Date'),
                subtitle: Text(
                  _selectedDate != null
                      ? _selectedDate!.toLocal().toString().split(' ')[0]
                      : 'No date selected',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDueDate,
                ),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                title: const Text('Mark as completed'),
                value: _isCompleted,
                onChanged: (value) => setState(() => _isCompleted = value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
