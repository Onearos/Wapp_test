import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app_test/features/weather/domain/entities/weather.dart';
import 'package:weather_app_test/features/weather/presentation/bloc/weather_bloc.dart';

class WeatherPage extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();

  WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/weath.png',
                ), // Add your own image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          BlocConsumer<WeatherBloc, WeatherState>(
            listener: (context, state) {
              if (state is WeatherLoaded || state is WeatherError) {
                _refreshController.refreshCompleted();
              }
            },
            builder: (context, state) {
              if (state is WeatherInitial) {
                context.read<WeatherBloc>().add(FetchWeather());
                return const Center(child: CircularProgressIndicator());
              } else if (state is WeatherLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WeatherError) {
                return Center(child: Text(state.message));
              } else if (state is WeatherLoaded) {
                return _buildWeatherContent(context, state.weather);
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherContent(BuildContext context, List<Weather> weather) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () => context.read<WeatherBloc>().add(FetchWeather()),
      header: const WaterDropHeader(waterDropColor: Colors.white),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: weather.length,
        itemBuilder: (context, index) {
          final item = weather[index];
          return _buildWeatherItem(context, item, index);
        },
      ),
    );
  }

  Widget _buildWeatherItem(BuildContext context, Weather weather, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300 + (index * 100)),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Time
                  Text(
                    '${weather.time.hour}:00',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Weather details
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${weather.temperature.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Feels ${weather.apparentTemperature.toStringAsFixed(1)}°C',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 50),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${weather.windSpeed.toStringAsFixed(1)} km/h',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Wind',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
