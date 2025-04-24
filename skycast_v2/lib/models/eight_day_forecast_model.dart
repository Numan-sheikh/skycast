import 'package:intl/intl.dart';

class EightDayForecastModel {
  final String dayLabel; // e.g., "Today", "Mon", "Tue"
  final String dateLabel; // e.g., "4/23", "5/12"
  final double maxTemp;
  final double minTemp;
  final String iconCode; // e.g., "01d", "02d"
  final double rainChance;
  final String condition; // e.g. "Cloudy", "Sunny"

  EightDayForecastModel({
    required this.dayLabel,
    required this.dateLabel,
    required this.maxTemp,
    required this.minTemp,
    required this.iconCode,
    required this.condition,
    this.rainChance = 0.0,
  });

  factory EightDayForecastModel.fromJson(Map<String, dynamic> json, int index) {
    final dt = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    final isToday = index == 0;
    final dayLabel = isToday ? "Today" : DateFormat('E').format(dt); // Mon, Tue
    final dateLabel = DateFormat('M/d').format(dt); // 4/23

    final maxTemp = (json['temp']['max'] as num).toDouble();
    final minTemp = (json['temp']['min'] as num).toDouble();
    final weather = json['weather'][0];
    final iconCode = weather['icon'];
    final condition = weather['main'];
    final rainChance =
        json['pop'] != null ? (json['pop'] as num).toDouble() * 100 : 0.0;

    return EightDayForecastModel(
      dayLabel: dayLabel,
      dateLabel: dateLabel,
      maxTemp: maxTemp,
      minTemp: minTemp,
      iconCode: iconCode,
      condition: condition,
      rainChance: rainChance,
    );
  }

  String getIconUrl() {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}
