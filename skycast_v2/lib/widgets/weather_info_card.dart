import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum CardShapeType { square, circle }

class WeatherInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color color;
  final Widget? customContent;
  final CardShapeType shapeType;

  const WeatherInfoCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.color = Colors.white,
    this.customContent,
    this.shapeType = CardShapeType.square,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isCircle = shapeType == CardShapeType.circle;

    Color fadedColor(Color baseColor, double opacity) {
      return baseColor.withAlpha((opacity * 255).round());
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: fadedColor(color, 0.08),
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircle ? null : BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Center(
            child:
                customContent ??
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null)
                      Icon(icon, size: 28, color: fadedColor(color, 0.9)),
                    const SizedBox(height: 6),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        value,
                        style: GoogleFonts.robotoMono(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: fadedColor(theme.colorScheme.onSurface, 0.9),
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                          color: fadedColor(theme.colorScheme.onSurface, 0.7),
                        ),
                      ),
                    ),
                    if (subtitle != null)
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            subtitle!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 11.5,
                              color: fadedColor(
                                theme.colorScheme.onSurface,
                                0.6,
                              ),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                  ],
                ),
          ),
        );
      },
    );
  }
}

class WeatherInfoCardGrid extends StatelessWidget {
  const WeatherInfoCardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cardData = [
      {
        'title': 'Precipitation',
        'value': '0 in',
        'subtitle': 'No precipitation expected',
        'icon': Icons.water_drop_outlined,
        'color': Colors.deepPurple,
      },
      {
        'title': 'Wind',
        'value': '6 mph',
        'subtitle': 'From NW',
        'icon': Icons.air,
        'color': Colors.blue,
      },
      {
        'title': 'Sunrise & Sunset',
        'value': '5:49 AM',
        'subtitle': '6:36 PM',
        'icon': Icons.wb_twilight,
        'color': Colors.orange,
      },
      {
        'title': 'UV Index',
        'value': '0',
        'subtitle': 'Low',
        'icon': Icons.wb_incandescent_outlined,
        'color': Colors.green,
      },
      {
        'title': 'Air Quality',
        'value': '155',
        'subtitle': 'Unhealthy',
        'icon': Icons.air,
        'color': Colors.redAccent,
      },
      {
        'title': 'Visibility',
        'value': '10 mi',
        'icon': Icons.remove_red_eye_outlined,
        'color': Colors.grey,
      },
      {
        'title': 'Humidity',
        'value': '20%',
        'subtitle': '7° Dew point',
        'icon': Icons.opacity,
        'color': Colors.indigo,
      },
      {
        'title': 'Pressure',
        'value': '29.68',
        'subtitle': 'inHg',
        'icon': Icons.speed,
        'color': Colors.teal,
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: cardData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final item = cardData[index];
          final shapeType =
              index % 2 == 1 ? CardShapeType.circle : CardShapeType.square;

          return WeatherInfoCard(
            title: item['title'],
            value: item['value'],
            subtitle: item['subtitle'],
            icon: item['icon'],
            color: item['color'],
            shapeType: shapeType,
          );
        },
      ),
    );
  }
}
