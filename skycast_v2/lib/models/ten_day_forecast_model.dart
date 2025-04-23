// models/ten_day_forecast_model.dart

class TenDayForecastModel {
  final String dayLabel;  // e.g., "Today", "Mon", "Tue"
  final String dateLabel; // e.g., "4/23", "5/12"
  final double maxTemp;
  final double minTemp;
  final String iconCode; // e.g., "01d", "02d"
  final double rainChance;
  final String condition; // e.g. "Cloudy", "Sunny"

  TenDayForecastModel({
    required this.dayLabel,
    required this.dateLabel,
    required this.maxTemp,
    required this.minTemp,
    required this.iconCode,
    required this.condition,
    this.rainChance = 0.0,
  });

  // Get the weather icon URL based on the iconCode
  String getIconUrl() {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png'; // Example URL
  }
}
