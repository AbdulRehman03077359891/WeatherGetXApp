import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Controllers/current_location_controller.dart';
import 'package:weather_app/Screen/User/setting_screen.dart';
import 'package:weather_app/Screen/User/weather_screen.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
import 'package:weather_app/Services/weather_services.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final WeatherServices weatherServices = Get.put(WeatherServices());
  final CurrentLocation currentLocation = Get.put(CurrentLocation());

  int _currentIndex = 0;
  late final List<Widget> _screens; // Use late initialization

  @override
  void initState() {
    super.initState();
    _screens = [
      const WeatherHome(),
      SettingsScreen(
        onNavigateToWeather: _navigateToWeather, // Pass method reference
      ),
    ];
    getCurrentLocation();
  }
  void _navigateToWeather() {
    setState(() {
      _currentIndex = 0; // Change to the weather screen
    });
  }

  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  getCurrentLocation() async {
    await currentLocation.getCurrentLocation(
        weatherServices.latitude.value, weatherServices.longitude.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF676BD0),
      body: _screens[_currentIndex],
      bottomNavigationBar: ResponsiveNavigationBar(
        selectedIndex: _currentIndex,
        onTabChange: changeTab,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        navigationBarButtons: const <NavigationBarButton>[
          NavigationBarButton(
            text: 'Weather',
            icon: Icons.cloud,
            backgroundGradient: LinearGradient(
              colors: [Colors.yellow, Colors.green, Colors.blue],
            ),
          ),
          NavigationBarButton(
            text: 'Settings',
            icon: Icons.settings,
            backgroundGradient: LinearGradient(
              colors: [Colors.green, Colors.yellow],
            ),
          ),
        ],
      ),
    );
  }
}
