import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:weather_app_test/core/network/api_client.dart';
import 'package:weather_app_test/features/weather/data/datasources/local_data_source.dart';
import 'package:weather_app_test/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app_test/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app_test/features/weather/presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => WeatherBloc(weatherRepository: sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      apiClient: sl(),
      localDataSource: sl(),
      connectivity: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  sl.registerLazySingleton<ApiClient>(() => ApiClient(client: Client()));

  // External services
  sl.registerLazySingleton(() => Connectivity());

  // Hive initialization
  await Hive.initFlutter();
  await Hive.openBox('weather');
}
