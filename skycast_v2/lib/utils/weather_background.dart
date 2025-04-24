import 'package:flutter/material.dart';

// Function to get the gradient based on weather condition
LinearGradient getWeatherGradient(String weatherCondition) {
  switch (weatherCondition.toLowerCase()) {
    case 'clear':
      return LinearGradient(
        colors: [Colors.blue.shade300, Colors.blue.shade700], // Clear Sky
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'cloudy':
      return LinearGradient(
        colors: [Colors.grey.shade500, Colors.grey.shade800], // Cloudy Sky
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'rain':
      return LinearGradient(
        colors: [Colors.blue.shade500, Colors.blue.shade900], // Rainy Weather
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'thunderstorm':
      return LinearGradient(
        colors: [Colors.black, Colors.deepPurple], // Thunderstorm
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'snow':
      return LinearGradient(
        colors: [Colors.white, Colors.blue.shade200], // Snowy Weather
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'drizzle':
      return LinearGradient(
        colors: [Colors.lightBlue.shade300, Colors.blue.shade600], // Drizzle
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    case 'mist':
      return LinearGradient(
        colors: [Colors.grey.shade300, Colors.grey.shade600], // Misty Weather
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    default:
      return LinearGradient(
        colors: [Colors.blue, Colors.blue.shade200], // Default Clear Sky
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  }
}

// Function to return an animated gradient background widget
Widget animatedWeatherBackground(String weatherCondition) {
  return TweenAnimationBuilder<Color>(
    tween: Tween<Color>(
      begin: getWeatherGradient(weatherCondition).colors.first,
      end: getWeatherGradient(weatherCondition).colors.last,
    ),
    duration: Duration(seconds: 2), // Duration for the color transition
    builder: (context, color, child) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, getWeatherGradient(weatherCondition).colors.last],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );
    },
  );
}
