import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Controllers/current_location_controller.dart';
import 'package:weather_app/Services/weather_services.dart';
import 'package:weather_app/Widgets/choose_city.dart';
import 'package:weather_app/Widgets/e1_button.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onNavigateToWeather;

  const SettingsScreen({super.key, required this.onNavigateToWeather});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final WeatherServices weatherServices = Get.put(WeatherServices());
  final CurrentLocation currentLocation = Get.put(CurrentLocation());
  final TextEditingController _city = TextEditingController();
  String? _selectedCity;
  double? _latitude;
  double? _longitude;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        CityChoose(
          controller: _city,
          selectedCity: _selectedCity,
          onChange: (city) {
            if (city != null) {
              final coordinates =
                  CityChoose.cityCoordinates[city]!; // Access cityCoordinates
              setState(() {
                _selectedCity = city;
                _latitude = coordinates[0]; // Update latitude
                _longitude = coordinates[1]; // Update longitude
              });
              weatherServices.setCoordinates(
                  _latitude!, _longitude!); // Update location controller
              weatherServices.startAutoFetchWeather();
              // Delay for 3 seconds before navigating to the weather screen
            Future.delayed(const Duration(seconds: 3), () {
              widget.onNavigateToWeather(); // Call the navigation callback
            });
            }
          },
          onCoordinatesChanged: (lat, lon) {
            // Update latitude and longitude in state
            setState(() {
              _latitude = lat;
              _longitude = lon;
            });
          },
          width: MediaQuery.of(context).size.width,
          fillColor: Colors.white12,
          labelColor: Colors.white,
          focusBorderColor: Colors.white,
          errorBorderColor: Colors.red,
        ),
        const SizedBox(height: 20),
        // Display selected coordinates if needed
        if (_latitude != null && _longitude != null)
          Text("Latitude: $_latitude, Longitude: $_longitude"),
        const SizedBox(
          height: 20,
        ),
        E1Button(
          backColor: Colors.purpleAccent,
          text: "Get Current Location",
          textColor: Colors.white,
          onPressed: () {
            currentLocation.getCurrentLocation(weatherServices.latitude.value,
                weatherServices.longitude.value);
            // Delay for 3 seconds before navigating to the weather screen
            Future.delayed(const Duration(seconds: 3), () {
              widget.onNavigateToWeather(); // Call the navigation callback
            });
          },
        )
      ],
    );
  }
}
