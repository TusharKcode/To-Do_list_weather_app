import 'package:flutter/material.dart';
import 'package:to_do_list_weather_app/screens/edit_task_screen.dart';
import 'package:to_do_list_weather_app/services/weather_service.dart';
import 'package:to_do_list_weather_app/screens/task_list_screen.dart';
import 'package:to_do_list_weather_app/screens/high_priority_screen.dart';
import 'package:to_do_list_weather_app/models/task.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const HomeScreen({super.key, required this.onToggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Map<String, dynamic>? weatherData;

  final WeatherService _weatherService = WeatherService();

  final GlobalKey<TaskListScreenState> _taskListKey = GlobalKey<TaskListScreenState>();

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  Future<void> loadWeather() async {
    final data = await _weatherService.fetchWeather();
    setState(() {
      weatherData = data;
    });
  }

  void onEditTask(Task task) async {
    bool? updated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTaskScreen(task: task)),
    );

    if (updated == true) {
      _taskListKey.currentState?.loadTasks();
    }
  }

  void onAddTask() async{
    bool? added = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );

    if (added == true) {
      _taskListKey.currentState?.loadTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      TaskListScreen(key: _taskListKey, onEdit: onEditTask, onAdd: onAddTask),
      HighPriorityScreen(onEdit: onEditTask),
    ];

    return Scaffold(
      appBar: AppBar(
          title: const Text('To-Do Weather App'),
          actions: [
            IconButton(onPressed: widget.onToggleTheme,
                icon: const Icon(Icons.brightness_6))
          ],
      ),
      body: Column(
        children: [
          if (weatherData != null)
            Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Image.network(
                    'https:${weatherData!['current']['condition']['icon']}'),
                title: Text('${weatherData!['current']['temp_c']}°C'),
                subtitle: Text(weatherData!['current']['condition']['text']),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),
          Expanded(child: screens[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white60,  // Active icon & label color
        unselectedItemColor: Colors.white,      // Inactive icon & label color
        backgroundColor: Colors.blue,         // Nav bar background color
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.priority_high), label: 'High Priority'),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}