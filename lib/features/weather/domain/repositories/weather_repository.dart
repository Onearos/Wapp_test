import 'package:weather_app_test/features/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<List<Weather>> getHourlyWeather();
}
