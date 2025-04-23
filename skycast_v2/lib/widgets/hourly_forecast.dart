import 'package:flutter/material.dart';
import 'package:skycast/models/hourly_weather_model.dart'; // Assuming the model is in this file

class HourlyForecast extends StatelessWidget {
  final List<HourlyWeatherModel> forecast;

  const HourlyForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final now = TimeOfDay.now().hour;

    // Show the next 24 hours from the current hour
    final next24Hours = forecast.skipWhile((hour) {
      final hourInt = int.tryParse(hour.time.split(':').first) ?? 0;
      return hourInt < now;
    }).take(24).toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.schedule, size: 18, color: Colors.white70),
                SizedBox(width: 8),
                Text(
                  "Hourly forecast",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: next24Hours.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final hour = next24Hours[index];
                final label = index == 0 ? "Now" : hour.time;

                return Container(
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(125),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Icon(hour.icon, color: Colors.white, size: 28),
                      const SizedBox(height: 6),
                      Text(
                        '${hour.temp}°',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
