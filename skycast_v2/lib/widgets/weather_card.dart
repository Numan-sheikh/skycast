import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String city;
  final double temperature;
  final String condition;
  final String icon;
  final double minTemp;
  final double maxTemp;
  final double windSpeed;
  final int humidity;

  const WeatherCard({
    super.key,
    required this.city,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.minTemp,
    required this.maxTemp,
    required this.windSpeed,
    required this.humidity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(city, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text('$temperature°C', style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 8),
            Text(condition),
            const SizedBox(height: 8),
            Image.network(
              'https://openweathermap.org/img/wn/$icon@2x.png',
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Min: $minTemp°C'),
                Text('Max: $maxTemp°C'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('💨 $windSpeed m/s'),
                Text('💧 $humidity%'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
