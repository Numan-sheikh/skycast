import 'package:flutter/material.dart';
import 'package:skycast/models/hourly_weather_model.dart';
import '../models/current_weather_model.dart';
import '../models/ten_day_forecast_model.dart'; // Only keep the relevant import
import '../widgets/current_weather.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/ten_day_forecast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Method to map icon codes to appropriate icons
  IconData getIconFromCode(String code) {
    switch (code) {
      case '01d':
        return Icons.wb_sunny; // Clear sky day
      case '02d':
        return Icons.cloud; // Few clouds
      case '03d':
        return Icons.cloud_queue; // Scattered clouds
      case '04d':
        return Icons.cloud_circle; // Broken clouds
      case '01n':
        return Icons.nightlight_round; // Clear sky night
      case '02n':
        return Icons.nights_stay; // Few clouds night
      case '03n':
        return Icons.cloud; // Scattered clouds night
      case '04n':
        return Icons.cloud_queue; // Broken clouds night
      default:
        return Icons.help; // Default icon for unknown conditions
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<HourlyWeatherModel> sampleData = [
      HourlyWeatherModel(time: 'Now', icon: Icons.nightlight_round, temp: 25),
      HourlyWeatherModel(time: '1 AM', icon: Icons.cloud, temp: 27),
      HourlyWeatherModel(time: '2 AM', icon: Icons.cloud, temp: 31),
      HourlyWeatherModel(time: '3 AM', icon: Icons.wb_sunny, temp: 34),
      HourlyWeatherModel(time: '4 AM', icon: Icons.wb_sunny, temp: 37),
      HourlyWeatherModel(time: '5 AM', icon: Icons.wb_sunny, temp: 38),
      HourlyWeatherModel(time: '6 AM', icon: Icons.wb_sunny, temp: 39),
      HourlyWeatherModel(time: '7 AM', icon: Icons.wb_sunny, temp: 41),
    ];

    final List<TenDayForecastModel> forecastData = [
      TenDayForecastModel(
        dayLabel: 'Today',
        dateLabel: '4/23',
        maxTemp: 30,
        minTemp: 20,
        iconCode: '01d',
        rainChance: 10,
        condition: '',
      ),
      TenDayForecastModel(
        dayLabel: 'Thu',
        dateLabel: '4/24',
        maxTemp: 28,
        minTemp: 18,
        iconCode: '02d',
        rainChance: 20,
        condition: '',
      ),
      TenDayForecastModel(
        dayLabel: 'Fri',
        dateLabel: '4/25',
        maxTemp: 32,
        minTemp: 22,
        iconCode: '03d',
        rainChance: 5,
        condition: '',
      ),
      TenDayForecastModel(
        dayLabel: 'Sat',
        dateLabel: '4/26',
        maxTemp: 31,
        minTemp: 21,
        iconCode: '04d',
        rainChance: 15,
        condition: '',
      ),
      TenDayForecastModel(
        dayLabel: 'Sun',
        dateLabel: '4/27',
        maxTemp: 33,
        minTemp: 23,
        iconCode: '01d',
        rainChance: 10,
        condition: '',
      ),
      TenDayForecastModel(
        dayLabel: 'Mon',
        dateLabel: '4/28',
        maxTemp: 34,
        minTemp: 24,
        iconCode: '02d',
        rainChance: 20,
        condition: '',
      ),
      TenDayForecastModel(
        dayLabel: 'Tue',
        dateLabel: '4/29',
        maxTemp: 35,
        minTemp: 25,
        iconCode: '03d',
        rainChance: 5,
        condition: '',
      ),
      TenDayForecastModel(
        dayLabel: 'Wed',
        dateLabel: '4/30',
        maxTemp: 36,
        minTemp: 26,
        iconCode: '04d',
        rainChance: 15,
        condition: '',
      ),
      TenDayForecastModel(
        dayLabel: 'Thu',
        dateLabel: '5/1',
        maxTemp: 30,
        minTemp: 20,
        iconCode: '01d',
        rainChance: 10,
        condition: '',
      ),
      TenDayForecastModel(
        dayLabel: 'Fri',
        dateLabel: '5/2',
        maxTemp: 28,
        minTemp: 18,
        iconCode: '02d',
        rainChance: 20,
        condition: '',
      ),
    ];

    final currentWeather = CurrentWeatherModel(
      cityName: 'New York',
      temperature: 25,
      description: 'Clear',
      iconCode: '01d',
      feelsLike: 25,
      tempMin: 22,
      tempMax: 28,
      humidity: 60,
      pressure: 1015,
      windSpeed: 5.5,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('SkyCast ☁️'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CurrentWeather(
                condition: currentWeather.description,
                temperature: currentWeather.temperature,
                feelsLike: currentWeather.feelsLike ?? 0,
                high: currentWeather.tempMax ?? 0,
                low: currentWeather.tempMin ?? 0,
                icon: getIconFromCode(currentWeather.iconCode),
              ),
              const SizedBox(height: 30),
              HourlyForecast(forecast: sampleData),
              const SizedBox(height: 30),
              TenDayForecast(
                forecast: forecastData,
              ), // Updated to pass the entire forecast data
            ],
          ),
        ),
      ),
    );
  }
}
