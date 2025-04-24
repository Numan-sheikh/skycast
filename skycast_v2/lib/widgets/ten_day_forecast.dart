import 'package:flutter/material.dart';
import '../models/eight_day_forecast_model.dart';

class TenDayForecast extends StatelessWidget {
  final List<EightDayForecastModel> forecast;

  const TenDayForecast({required this.forecast, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withAlpha(20),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: theme.colorScheme.onSurface.withAlpha(180),
                ),
                const SizedBox(width: 8),
                Text(
                  "10-day forecast",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: SizedBox(
              height: 240,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                        color: theme.colorScheme.primary.withAlpha(8),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(30),
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
                            style: TextStyle(
                              fontSize: 16,
                              color: theme.colorScheme.onSurface.withAlpha(230),
                            ),
                          ),
                          Text(
                            '${day.minTemp.toInt()}°',
                            style: TextStyle(
                              fontSize: 14,
                              color: theme.colorScheme.onSurface.withAlpha(140),
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
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface.withAlpha(160),
                            ),
                          ),
                          if (day.rainChance > 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                '${day.rainChance.toInt()}%',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                            ),
                          const SizedBox(height: 8),
                          Text(
                            day.dayLabel,
                            style: TextStyle(
                              fontSize: 13,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            day.dateLabel,
                            style: TextStyle(
                              fontSize: 11,
                              color: theme.colorScheme.onSurface.withAlpha(130),
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
