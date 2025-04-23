import 'package:flutter/material.dart';
import '../models/ten_day_forecast_model.dart';

class TenDayForecast extends StatelessWidget {
  final List<TenDayForecastModel> forecast;

  const TenDayForecast({required this.forecast, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.only(top: 24, bottom: 12),
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
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Colors.white70,
                ),
                SizedBox(width: 8),
                Text(
                  "10-day forecast",
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
          ClipRRect(
            borderRadius: BorderRadius.circular(28), // Same as your container
            child: SizedBox(
              height: 240,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shrinkWrap: true,
                itemCount: forecast.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final day = forecast[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${day.dayLabel} tapped')),
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      width: screenWidth * 0.24,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(122),
                            offset: const Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 6,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${day.maxTemp.toInt()}°',
                            textScaler: const TextScaler.linear(1.0),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${day.minTemp.toInt()}°',
                            textScaler: const TextScaler.linear(1.0),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white60,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Image.network(
                            day.getIconUrl(),
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            day.condition,
                            textAlign: TextAlign.center,
                            textScaler: const TextScaler.linear(1.0),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          if (day.rainChance > 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                '${day.rainChance.toInt()}%',
                                textScaler: const TextScaler.linear(1.0),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                            ),
                          const SizedBox(height: 8),
                          Text(
                            day.dayLabel,
                            textScaler: const TextScaler.linear(1.0),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            day.dateLabel,
                            textScaler: const TextScaler.linear(1.0),
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
