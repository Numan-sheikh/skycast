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
}
