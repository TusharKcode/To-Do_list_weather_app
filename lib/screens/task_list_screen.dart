import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/db_service.dart';
import 'package:share_plus/share_plus.dart';

class TaskListScreen extends StatefulWidget {
  final Function(Task) onEdit;
  final VoidCallback onAdd;                             // <-- Add this to handle Add button action

  const TaskListScreen({super.key, required this.onEdit, required this.onAdd});

  @override
  TaskListScreenState createState() => TaskListScreenState();
}

class TaskListScreenState extends State<TaskListScreen> {
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

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task deleted'),
        behavior: SnackBarBehavior.floating,),
      );
      loadTasks();
    }
  }

  void toggleHighPriority(Task task) async {
    task.isHighPriority = !task.isHighPriority;
    await _dbService.updateTask(task);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            task.isHighPriority ? 'Marked as High Priority' : 'Removed from High Priority',)
          ,behavior: SnackBarBehavior.floating,
        ),
      );
      loadTasks();
    }
  }

  void shareTask(Task task){
    Share.share("Task: ${task.title}\n Description: ${task.description}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("To-Do List")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () => shareTask(task),
                  icon: const Icon(Icons.share, color: Colors.blue),
                ),
                IconButton(onPressed: () => deleteTask(task.id!),
                    icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            onTap: () => widget.onEdit(task),
            onLongPress: () => toggleHighPriority(task),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onAdd,                                  // You’ll define this callback from parent
        child: const Icon(Icons.add),
      ),
    );
  }
}
