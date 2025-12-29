// temperature.dart
class Temperature {
  final double current;

  Temperature({required this.current});

  factory Temperature.fromJson(double temp) {
    return Temperature(current: temp);
  }
}
