import 'package:flutter/material.dart';
import 'package:skycast/models/hourly_weather_model.dart'; // Make sure this exists and provides icon, time, temp

class HourlyForecast extends StatelessWidget {
  final List<HourlyWeatherModel> forecast;

  const HourlyForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final now = TimeOfDay.now().hour;

    // Show the next 24 hours from the current hour
    final next24Hours =
        forecast
            .skipWhile((hour) {
              final hourInt = int.tryParse(hour.time.split(':').first) ?? 0;
              return hourInt < now;
            })
            .take(24)
            .toList();

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
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: next24Hours.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final hour = next24Hours[index];
                final label = index == 0 ? "Now" : _formatHourLabel(hour.time);
                final isNow = index == 0;

                return Container(
                  width: 52,
                  decoration: BoxDecoration(
                    color: isNow ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${hour.temp}°',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isNow ? Colors.black : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Icon(
                        hour.icon,
                        color: isNow ? Colors.black : Colors.white,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          color: isNow ? Colors.black : Colors.white70,
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

  /// Helper to convert "17:00" to "5 PM"
  String _formatHourLabel(String time24) {
    final parts = time24.split(':');
    final hour = int.tryParse(parts.first) ?? 0;
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return '$hour12 $period';
  }
}
