import 'package:flutter/material.dart';

class WeatherInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const WeatherInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.amberAccent),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
  }
}
