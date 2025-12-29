// weather_info.dart
class WeatherInfo {
  final String main; // Ensure this property exists
  final String description; // You can add other properties as needed

  WeatherInfo({required this.main, required this.description});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      main: json['main'], // Ensure the 'main' key is present in the API response
      description: json['description'], // Similarly for description
    );
  }
}
