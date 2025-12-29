import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Services/weather_services.dart';
import 'package:weather_app/widgets/weather_details.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {



  
  @override
  Widget build(BuildContext context) {
    final WeatherServices weatherServices = Get.put(WeatherServices());

    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,),
      child: Obx(() {
        if (weatherServices.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        } else {
          final weather = weatherServices.weatherData.value;
          String formattedDate = DateFormat('EEEE d, MMMM yyyy').format(DateTime.now());
          String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Center(
                  child: WeatherDetail(
                    weather: weather,
                    formattedDate: formattedDate,
                    formattedTime: formattedTime,
                  ),
                ),
                const SizedBox(height: 80,),
              ],
            ),
          );
        }
      }),
    );
  }
}
