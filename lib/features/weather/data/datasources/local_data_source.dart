import 'package:hive/hive.dart';

abstract class LocalDataSource {
  Future<void> cacheWeatherData(List<Map<String, dynamic>> data);
  Future<List<Map<String, dynamic>>> getCachedWeatherData();
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> cacheWeatherData(List<Map<String, dynamic>> data) async {
    final box = await Hive.openBox('weather');
    await box.put('hourly', data);
  }

  @override
  Future<List<Map<String, dynamic>>> getCachedWeatherData() async {
    final box = await Hive.openBox('weather');
    final data = box.get('hourly');
    if (data != null) {
      return (data as List)
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    return [];
  }
}
