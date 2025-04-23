class CurrentWeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final String iconCode;

  // Optional fields for more weather details
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? humidity;
  final int? pressure;
  final double? windSpeed;

  CurrentWeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.iconCode,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.humidity,
    this.pressure,
    this.windSpeed,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
      feelsLike: json['main']['feels_like']?.toDouble(),
      tempMin: json['main']['temp_min']?.toDouble(),
      tempMax: json['main']['temp_max']?.toDouble(),
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      windSpeed: json['wind']['speed']?.toDouble(),
    );
  }

  String getIconUrl() {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}
