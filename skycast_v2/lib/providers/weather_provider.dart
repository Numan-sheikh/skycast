import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/current_weather_model.dart'; // Updated import
import '../models/eight_day_forecast_model.dart'; // Import EightDayForecastModel
import '../services/location_service.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();

  CurrentWeatherModel? _weather;
  List<EightDayForecastModel>? _forecast; // Changed to EightDayForecastModel
  bool _isLoading = false;
  String? _error;

  CurrentWeatherModel? get weather => _weather;
  List<EightDayForecastModel>? get forecast =>
      _forecast; // Changed to EightDayForecastModel
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadWeather() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final Position? position = await _locationService.getCurrentLocation();
      if (position != null) {
        final weatherData = await _weatherService.fetchWeatherByCoords(
          position.latitude,
          position.longitude,
        );
        if (weatherData != null) {
          _weather = weatherData; // Current weather
        }

        final forecastData = await _weatherService
            .fetchEightDayForecastByCoords(
              position.latitude,
              position.longitude,
            );
        if (forecastData != null) {
          _forecast = forecastData; // 8-day forecast
        }
      } else {
        _error = 'Location unavailable.';
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
