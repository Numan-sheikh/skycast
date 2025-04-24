import 'package:flutter/material.dart';
import 'package:skycast/models/hourly_weather_model.dart';

class HourlyForecast extends StatelessWidget {
  final List<HourlyWeatherModel> forecast;

  const HourlyForecast({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final now = TimeOfDay.now().hour;

    final next24Hours =
        forecast
            .skipWhile((hour) {
              final hourInt = int.tryParse(hour.time.split(':').first) ?? 0;
              return hourInt < now;
            })
            .take(24)
            .toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 114, 112, 112).withAlpha(15),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).round()),

            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.schedule, size: 18, color: const Color.fromARGB(255, 97, 93, 93)),
                const SizedBox(width: 8),
                Text(
                  "Hourly forecast",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: next24Hours.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final hour = next24Hours[index];
                final label = index == 0 ? "Now" : _formatHourLabel(hour.time);
                final isNow = index == 0;

                return Container(
                  width: 60,
                  decoration: BoxDecoration(
                    color:
                        isNow
                            ? const Color.fromARGB(255, 201, 197, 197).withAlpha(40)
                            : const Color.fromARGB(255, 173, 172, 172).withAlpha(20),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          isNow
                              ? const Color.fromARGB(255, 255, 255, 255).withAlpha(115)
                              : const Color.fromARGB(255, 255, 255, 255).withAlpha(115),
                      width: isNow ? 1.5 : 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${hour.temp}°',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isNow ? Colors.black87 : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Icon(
                        hour.icon,
                        color: isNow ? Colors.black87 : Colors.grey.shade600,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          color: isNow ? Colors.black87 : Colors.grey.shade700,
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

  String _formatHourLabel(String time24) {
    final parts = time24.split(':');
    final hour = int.tryParse(parts.first) ?? 0;
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return '$hour12 $period';
  }
}
