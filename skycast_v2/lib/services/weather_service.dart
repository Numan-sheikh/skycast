import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart'; // Import the logger package
import '../models/current_weather_model.dart'; // Import CurrentWeatherModel
import '../models/daily_weather_model.dart'; // Import DailyWeatherModel

class WeatherService {
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/';
  final String _apiKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  final Logger _logger = Logger(); // Create a Logger instance

  // Method to fetch current weather by coordinates
  Future<CurrentWeatherModel?> fetchWeatherByCoords(
    double lat,
    double lon,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=$_apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return CurrentWeatherModel.fromJson(json); // Use CurrentWeatherModel
      } else {
        _logger.e(
          'Error fetching current weather: ${response.statusCode}',
        ); // Log error
        return null;
      }
    } catch (e) {
      _logger.e('Exception fetching current weather: $e'); // Log exception
      return null;
    }
  }

  // Method to fetch 10-day forecast by coordinates
  Future<List<DailyWeatherModel>?> fetchForecastByCoords(
    double lat,
    double lon,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/onecall?lat=$lat&lon=$lon&exclude=current,minutely,hourly&units=metric&appid=$_apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final dailyForecast =
            (json['daily'] as List)
                .map(
                  (item) => DailyWeatherModel.fromJson(item),
                ) // Use DailyWeatherModel
                .toList();
        return dailyForecast;
      } else {
        _logger.e(
          'Error fetching forecast: ${response.statusCode}',
        ); // Log error
        return null;
      }
    } catch (e) {
      _logger.e('Exception fetching forecast: $e'); // Log exception
      return null;
    }
  }
}
