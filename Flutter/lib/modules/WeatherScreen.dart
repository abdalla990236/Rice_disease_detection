import 'package:flutter/material.dart';
import 'weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  static const String id = 'weather_screen';
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService weatherService = WeatherService();
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  Future<void> loadWeather() async {
    try {
      final data = await weatherService.fetchWeather('Sohag');
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      print('Error loading weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Weather Forecast")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final current = weatherData!['current'];
    final forecast = weatherData!['forecast']['forecastday'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Forecast"),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Weather", style: TextStyle(fontWeight: FontWeight.bold)),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Today, ${forecast[0]['date']}"),
                        Text("${current['temp_c']} °C", style: TextStyle(fontSize: 28)),
                        Text("${current['condition']['text']}"),
                        Row(
                          children: [
                            Icon(Icons.water_drop, size: 18, color: Colors.blue),
                            Text(" ${current['humidity']}%"),
                          ],
                        ),
                        Text("${weatherData!['location']['name']}"),
                      ],
                    ),
                    Spacer(),
                    Image.network("https:${current['condition']['icon']}", width: 64),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text("Next 3 days"),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(forecast.length, (index) {
                final day = forecast[index];
                return Column(
                  children: [
                    Text(
                      DateTime.parse(day['date']).weekday == DateTime.now().weekday
                          ? "Today"
                          : ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][
                      DateTime.parse(day['date']).weekday - 1],
                    ),
                    Image.network("https:${day['day']['condition']['icon']}", width: 40),
                    Text("${day['day']['maxtemp_c']}°C"),
                  ],
                );
              }),
            ),
            SizedBox(height: 16),
            Text("No rain is forecast this week"),
          ],
        ),
      ),
    );
  }
}
