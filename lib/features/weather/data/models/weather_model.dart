import 'package:equatable/equatable.dart';
import 'package:weather_app_test/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required DateTime time,
    required double temperature,
    required double apparentTemperature,
    required double windSpeed,
  }) : super(
         time: time,
         temperature: temperature,
         apparentTemperature: apparentTemperature,
         windSpeed: windSpeed,
       );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      time: DateTime.parse(json['startTime']),
      temperature: (json['values']['temperature'] as num).toDouble(),
      apparentTemperature: (json['values']['temperatureApparent'] as num)
          .toDouble(),
      windSpeed: (json['values']['windSpeed'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': time.toIso8601String(),
      'values': {
        'temperature': temperature,
        'temperatureApparent': apparentTemperature,
        'windSpeed': windSpeed,
      },
    };
  }
}
