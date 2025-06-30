import 'package:flutter/material.dart';
import 'package:to_do_list_weather_app/services/weather_service.dart';
import 'package:to_do_list_weather_app/screens/task_list_screen.dart';
import 'package:to_do_list_weather_app/screens/high_priority_screen.dart';
import 'package:to_do_list_weather_app/models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Map<String, dynamic>? weatherData;

  final WeatherService _weatherService = WeatherService();

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

  void onEditTask(Task task) {
    // You can show edit screen logic here
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      TaskListScreen(onEdit: onEditTask),
      HighPriorityScreen(onEdit: onEditTask),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('To-Do Weather App')),
      body: Column(
        children: [
          if (weatherData != null)
            Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Image.network('https:${weatherData!['current']['condition']['icon']}'),
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
    );
  }
}
