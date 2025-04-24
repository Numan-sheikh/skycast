import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart'; // Import the logger package
import '../models/current_weather_model.dart'; // Import CurrentWeatherModel
import '../models/hourly_weather_model.dart'; // Import HourlyWeatherModel
import '../models/eight_day_forecast_model.dart'; // Import EightDayForecastModel

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

  // Method to fetch 8-day forecast by coordinates
  Future<List<EightDayForecastModel>?> fetchEightDayForecastByCoords(
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
        final dailyList =
            (json['daily'] as List)
                .take(8) // Only take 8 days
                .map(
                  (item) => EightDayForecastModel.fromJson(item, 0),
                ) // Update to EightDayForecastModel
                .toList();
        return dailyList;
      } else {
        _logger.e('Error fetching 8-day forecast: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('Exception fetching 8-day forecast: $e');
      return null;
    }
  }

  // Method to fetch hourly forecast by coordinates
  Future<List<HourlyWeatherModel>?> fetchHourlyForecastByCoords(
    double lat,
    double lon,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=$_apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final hourlyList =
            (json['list'] as List)
                .map(
                  (item) => HourlyWeatherModel.fromJson(item),
                ) // Use fromJson
                .toList();
        return hourlyList;
      } else {
        _logger.e('Error fetching hourly forecast: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('Exception fetching hourly forecast: $e');
      return null;
    }
  }
}
