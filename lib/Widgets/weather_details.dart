import 'package:flutter/material.dart';
import 'package:weather_app/Model/weather_data.dart';
import 'package:weather_app/widgets/weather_info_card.dart';

class WeatherDetail extends StatelessWidget {
  final WeatherData weather;
  final String formattedDate;
  final String formattedTime;

  const WeatherDetail({
    super.key,
    required this.weather,
    required this.formattedDate,
    required this.formattedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          weather.name,
          style: const TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          "${weather.temperature.current.toStringAsFixed(2)}°C",
          style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        if (weather.weather.isNotEmpty)
          Text(
            weather.weather[0].main,
            style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        const SizedBox(height: 30),
        Text(
          formattedDate,
          style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          formattedTime,
          style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/Cloudy.png")),
          ),
        ),
        const SizedBox(height: 30),
        _buildWeatherDetails(),
      ],
    );
  }

  Widget _buildWeatherDetails() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherInfoCard(title: "Wind", value: "${(weather.wind.speed * 3.6).toStringAsFixed(2)} km/h", icon: Icons.wind_power),
                WeatherInfoCard(title: "Max", value: "${weather.maxTemperature.toStringAsFixed(2)}°C", icon: Icons.sunny),
                WeatherInfoCard(title: "Min", value: "${weather.minTemperature.toStringAsFixed(2)}°C", icon: Icons.thermostat),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherInfoCard(title: "Humidity", value: "${weather.humidity}%", icon: Icons.water_drop),
                WeatherInfoCard(title: "Pressure", value: "${weather.pressure} hPa", icon: Icons.air),
                WeatherInfoCard(title: "Sea-Level", value: "${weather.seaLevel} m", icon: Icons.leaderboard),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
