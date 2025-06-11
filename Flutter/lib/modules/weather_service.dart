import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'de09fab7adb74d9594b232720232504';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=5&aqi=no&alerts=no');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
