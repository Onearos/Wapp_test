import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app_test/features/weather/domain/entities/weather.dart';
import 'package:weather_app_test/features/weather/domain/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getHourlyWeather();
      emit(WeatherLoaded(weather: weather));
    } catch (e) {
      try {
        final cachedWeather = await weatherRepository.getHourlyWeather();
        emit(WeatherLoaded(weather: cachedWeather, isFromCache: true));
      } catch (e) {
        emit(WeatherError(message: e.toString()));
      }
    }
  }
}
