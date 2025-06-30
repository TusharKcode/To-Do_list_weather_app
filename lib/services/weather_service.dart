import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class WeatherService {
  final String apiKey = '7364f327f5aa474ea00133412252806'; // <-- Put your weatherapi.com key here

  Future<Map<String, dynamic>?> fetchWeather() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check service
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Check permissions
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    // Get current location
    final locData = await location.getLocation();
    final lat = locData.latitude;
    final lon = locData.longitude;

    // Fetch weather data
    final url = Uri.parse('https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$lat,$lon');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}
