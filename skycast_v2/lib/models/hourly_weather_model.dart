import 'package:flutter/material.dart';

class HourlyWeatherModel {
  final String time; // Time in 24-hour format, e.g., "14:00"
  final IconData icon; // The icon for the weather condition
  final int temp; // Temperature for that hour

  HourlyWeatherModel({
    required this.time,
    required this.icon,
    required this.temp,
  });

  // Define fromJson method to map JSON data to HourlyWeatherModel
  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    // Map the icon code to an IconData or image URL if needed
    String iconCode = json['weather'][0]['icon'];
    IconData icon = _getIconFromCode(
      iconCode,
    ); // Helper function to convert icon code to IconData

    return HourlyWeatherModel(
      time: json['dt_txt'], // Assuming dt_txt is the field for time in the JSON
      icon: icon,
      temp: (json['main']['temp'] as num).toInt(), // Extract the temperature
    );
  }

  // Helper function to map icon code to an IconData (or image URL)
  static IconData _getIconFromCode(String code) {
    switch (code) {
      case '01d':
        return Icons.wb_sunny;
      case '02d':
        return Icons.cloud;
      case '03d':
        return Icons.cloud_queue;
      // Add other icon cases based on your needs
      default:
        return Icons.help; // Default icon for unknown codes
    }
  }
}
