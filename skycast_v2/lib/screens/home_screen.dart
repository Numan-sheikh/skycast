import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

import '../models/current_weather_model.dart';
import '../models/hourly_weather_model.dart';
import '../models/eight_day_forecast_model.dart';
import '../widgets/current_weather.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/ten_day_forecast.dart';
import '../widgets/weather_info_card.dart'; // Import the custom weather card

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  IconData getIconFromCode(String code) {
    switch (code) {
      case '01d':
        return Icons.wb_sunny;
      case '02d':
        return Icons.cloud;
      case '03d':
        return Icons.cloud_queue;
      case '04d':
        return Icons.cloud_circle;
      case '01n':
        return Icons.nightlight_round;
      case '02n':
        return Icons.nights_stay;
      case '03n':
        return Icons.cloud;
      case '04n':
        return Icons.cloud_queue;
      default:
        return Icons.help;
    }
  }

  List<HourlyWeatherModel> generateHourlyForecast() {
    final now = DateTime.now();
    final random = Random();
    final List<IconData> weatherIcons = [
      Icons.wb_sunny,
      Icons.cloud,
      Icons.cloud_queue,
      Icons.nightlight_round,
      Icons.nights_stay,
    ];

    return List.generate(24, (index) {
      final hour = now.add(Duration(hours: index));
      final formattedHour = DateFormat('HH:00').format(hour);
      return HourlyWeatherModel(
        time: index == 0 ? 'Now' : formattedHour,
        icon: weatherIcons[random.nextInt(weatherIcons.length)],
        temp: 20 + random.nextInt(15),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<HourlyWeatherModel> sampleData = generateHourlyForecast();

    final List<EightDayForecastModel> forecastData = [
      EightDayForecastModel(
        dayLabel: 'Today',
        dateLabel: '4/23',
        maxTemp: 30,
        minTemp: 20,
        iconCode: '01d',
        rainChance: 10,
        condition: '',
      ),
      EightDayForecastModel(
        dayLabel: 'Thu',
        dateLabel: '4/24',
        maxTemp: 28,
        minTemp: 18,
        iconCode: '02d',
        rainChance: 20,
        condition: '',
      ),
      EightDayForecastModel(
        dayLabel: 'Fri',
        dateLabel: '4/25',
        maxTemp: 32,
        minTemp: 22,
        iconCode: '03d',
        rainChance: 5,
        condition: '',
      ),
      EightDayForecastModel(
        dayLabel: 'Sat',
        dateLabel: '4/26',
        maxTemp: 31,
        minTemp: 21,
        iconCode: '04d',
        rainChance: 15,
        condition: '',
      ),
      EightDayForecastModel(
        dayLabel: 'Sun',
        dateLabel: '4/27',
        maxTemp: 33,
        minTemp: 23,
        iconCode: '01d',
        rainChance: 10,
        condition: '',
      ),
      EightDayForecastModel(
        dayLabel: 'Mon',
        dateLabel: '4/28',
        maxTemp: 34,
        minTemp: 24,
        iconCode: '02d',
        rainChance: 20,
        condition: '',
      ),
      EightDayForecastModel(
        dayLabel: 'Tue',
        dateLabel: '4/29',
        maxTemp: 35,
        minTemp: 25,
        iconCode: '03d',
        rainChance: 5,
        condition: '',
      ),
      EightDayForecastModel(
        dayLabel: 'Wed',
        dateLabel: '4/30',
        maxTemp: 36,
        minTemp: 26,
        iconCode: '04d',
        rainChance: 15,
        condition: '',
      ),
      EightDayForecastModel(
        dayLabel: 'Thu',
        dateLabel: '5/1',
        maxTemp: 30,
        minTemp: 20,
        iconCode: '01d',
        rainChance: 10,
        condition: '',
      ),
      EightDayForecastModel(
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
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Stack(
          children: [
            // Blur background
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha((255 * 0.15).toInt()),
                    // subtle dark translucent
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
                  ),
                ),
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'SkyCast ☁️',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 100,
        ), // Give space for translucent bar
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
              TenDayForecast(forecast: forecastData),
              const SizedBox(height: 30),
              const SizedBox(height: 40),
              const WeatherInfoCardGrid(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
