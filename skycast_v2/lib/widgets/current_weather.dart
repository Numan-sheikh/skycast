import 'package:flutter/material.dart';

class CurrentWeather extends StatelessWidget {
  final String condition;
  final double temperature;
  final double feelsLike;
  final double high;
  final double low;
  final IconData icon;

  const CurrentWeather({
    super.key,
    required this.condition,
    required this.temperature,
    required this.feelsLike,
    required this.high,
    required this.low,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            const SizedBox(width: 10),
            Text(
              '$temperature°C',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(condition, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        Text(
          'Feels like: $feelsLike°C | High: $high°C | Low: $low°C',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
