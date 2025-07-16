import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weather_app_test/core/network/api_client.dart';
import 'package:weather_app_test/features/weather/data/datasources/local_data_source.dart';
import 'package:weather_app_test/features/weather/data/models/weather_model.dart';
import 'package:weather_app_test/features/weather/domain/entities/weather.dart';
import 'package:weather_app_test/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final ApiClient apiClient;
  final LocalDataSource localDataSource;
  final Connectivity connectivity;

  WeatherRepositoryImpl({
    required this.apiClient,
    required this.localDataSource,
    required this.connectivity,
  });

  @override
  Future<List<Weather>> getHourlyWeather() async {
    try {
      final response = await apiClient.getWeatherData();
      final data = json.decode(response) as Map<String, dynamic>;
      final hourlyData = _extractHourlyData(data);

      await localDataSource.cacheWeatherData(hourlyData);

      return hourlyData
          .map((interval) => WeatherModel.fromJson(interval))
          .toList();
    } catch (e) {
      final cachedData = await localDataSource.getCachedWeatherData();
      if (cachedData.isNotEmpty) {
        return cachedData
            .map((interval) => WeatherModel.fromJson(interval))
            .toList();
      }
      throw WeatherException(
        'No internet connection and no cached data available',
      );
    }
  }

  List<Map<String, dynamic>> _extractHourlyData(Map<String, dynamic> data) {
    final timelines = data['data']['timelines'] as List;
    final hourlyTimeline = timelines.firstWhere(
      (timeline) => timeline['timestep'] == '1h',
      orElse: () => null,
    );

    if (hourlyTimeline == null) {
      throw WeatherException('No hourly data available');
    }

    return (hourlyTimeline['intervals'] as List).map((interval) {
      return Map<String, dynamic>.from(interval as Map);
    }).toList();
  }
}

class WeatherException implements Exception {
  final String message;
  WeatherException(this.message);

  @override
  String toString() => 'WeatherException: $message';
}
