import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final theme = Theme.of(context);
    final Color primaryColor = theme.colorScheme.primary;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(
          (0.06 * 255).toInt(),
        ), // Replacing withOpacity(0.06)
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: primaryColor.withAlpha((0.9 * 255).toInt()),
              ),
              const SizedBox(width: 16),
              Text(
                '${temperature.toStringAsFixed(1)}°C',
                style: GoogleFonts.robotoMono(
                  fontSize: 42,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface.withAlpha(
                    (0.9 * 255).toInt(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            condition,
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface.withAlpha((0.8 * 255).toInt()),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Feels like: ${feelsLike.toStringAsFixed(1)}°C • High: ${high.toStringAsFixed(1)}°C • Low: ${low.toStringAsFixed(1)}°C',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: theme.colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
