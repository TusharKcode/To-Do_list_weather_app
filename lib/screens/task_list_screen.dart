import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/db_service.dart';

class TaskListScreen extends StatefulWidget {
  final Function(Task) onEdit;

  const TaskListScreen({super.key, required this.onEdit});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final DBService _dbService = DBService();
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final data = await _dbService.getTasks();
    setState(() {
      tasks = data;
    });
  }

  void deleteTask(int id) async {
    await _dbService.deleteTask(id);
    loadTasks();
  }

  void toggleHighPriority(Task task) async {
    task.isHighPriority = !task.isHighPriority;
    await _dbService.updateTask(task);
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text(task.description),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => deleteTask(task.id!),
          ),
          onTap: () => widget.onEdit(task),
          onLongPress: () => toggleHighPriority(task),
        );
      },
    );
  }
}
