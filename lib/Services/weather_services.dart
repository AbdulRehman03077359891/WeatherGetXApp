import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/API/weather_apis.dart';
import 'package:weather_app/Model/weather_data.dart';

class WeatherServices extends GetxController {
  Timer? _timer;
  var weatherData = WeatherData.empty().obs; // Use the empty constructor
  var isLoading = false.obs; // Reactive variable to track loading state
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  void setCoordinates(double lat, double lon) {
    latitude.value = lat;
    longitude.value = lon;
  }
  // This will fetch the weather data periodically based on the interval
  void startAutoFetchWeather({int intervalInMinutes = 1}) {
    // Cancel any existing timer
    _timer?.cancel();

    // Fetch weather data immediately
    fetchWeather();

    // Set a timer to fetch new data periodically
    _timer = Timer.periodic(Duration(minutes: intervalInMinutes), (Timer timer) {
      fetchWeather();
    });
  }

  // Fetch weather data from API
  Future<void> fetchWeather() async {
    try {
      // isLoading.value = true; // Set loading state to true
      final url = "https://api.openweathermap.org/data/2.5/weather?lat=${latitude.value}&lon=${longitude.value}&appid=$weatherApiKey&units=metric";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print('Weather data fetched successfully: $json');
        weatherData.value = WeatherData.fromJson(json); // Update reactive variable
      } else {
        print('Failed to load Weather Data, Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      // isLoading.value = false; // Set loading state to false
    }
  }

  // Stop auto-fetching when no longer needed
  void stopAutoFetch() {
    _timer?.cancel();
  }
}
