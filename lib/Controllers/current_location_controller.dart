import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/Services/weather_services.dart';
import 'package:weather_app/Widgets/notification_message.dart';

class CurrentLocation extends GetxController{
  final WeatherServices weatherServices = Get.put(WeatherServices());
  // Finding Address -------------------------------------------------------
  late Position _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  String currentAddress = "non";

  getCurrentLocation(lat, lon) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't proceed.
      notify("error", "Location services are disabled.");
      return null;
    }

    // Check for permission.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, show a message.
        notify("error", "Location permissions are denied.");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, show a message.
      notify("error", "Location permissions are permanently denied.");
      return null;
    }

    // If everything is fine, return the position.
    try {
      _currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10), // Optional timeout
      );
      weatherServices.latitude.value = _currentLocation.latitude;
      weatherServices.longitude.value = _currentLocation.longitude;
    } catch (e) {
      // Catch any errors and show a message.
      notify("error", "Failed to get location: $e");
      return null;
    } finally{
      await getAddressFromCoordination(lat, lon);
    }
  }

  getAddressFromCoordination(lat, lon) async {
    try {
      List<Placemark> placeMark = await placemarkFromCoordinates(
          _currentLocation.latitude, _currentLocation.longitude);

      if (placeMark.isNotEmpty) {
        Placemark place1 = placeMark[0];
        Placemark place3 = placeMark[2];
        Placemark place4 = placeMark[3];

          lat = _currentLocation.latitude;
          lon = _currentLocation.longitude;
          currentAddress =
              "${place3.name}, ${place4.name}, ${place1.subLocality}, ${place1.locality}, ${place1.administrativeArea}, ${place1.country}";

        update();
        weatherServices.startAutoFetchWeather(); // Example coordinates
      } else {
        notify("error", "No placemark found");
      }
        } catch (e) {
      notify("error", "Failed to get placemark: $e");
    }
  }

}