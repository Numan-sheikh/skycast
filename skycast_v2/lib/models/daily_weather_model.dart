import 'package:intl/intl.dart';

class DailyWeatherModel {
  final String day;
  final double maxTemp;
  final double minTemp;
  final String iconCode;

  // ✅ Newly added fields (non-breaking additions)
  final DateTime date;
  final double rainChance;

  DailyWeatherModel({
    required this.day,
    required this.maxTemp,
    required this.minTemp,
    required this.iconCode,
    required this.date,
    this.rainChance = 0.0,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    final date = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    final dayName = _dayOfWeek(date);
    final rain = (json['pop'] ?? 0.0) * 100;

    return DailyWeatherModel(
      day: dayName,
      maxTemp: json['temp']['max'].toDouble(),
      minTemp: json['temp']['min'].toDouble(),
      iconCode: json['weather'][0]['icon'],
      date: date,
      rainChance: rain,
    );
  }

  String getIconUrl() {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }

  static String _dayOfWeek(DateTime date) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[date.weekday % 7];
  }

  // ✅ Extra computed properties
  String get dayLabel {
    final today = DateTime.now();
    if (today.year == date.year &&
        today.month == date.month &&
        today.day == date.day) {
      return "Today";
    }
    return day;
  }

  String get dateLabel => DateFormat('M/d').format(date);
}
