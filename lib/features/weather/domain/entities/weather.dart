import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final DateTime time;
  final double temperature;
  final double apparentTemperature;
  final double windSpeed;

  const Weather({
    required this.time,
    required this.temperature,
    required this.apparentTemperature,
    required this.windSpeed,
  });

  @override
  List<Object?> get props => [
    time,
    temperature,
    apparentTemperature,
    windSpeed,
  ];
}
