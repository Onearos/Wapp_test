import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_test/core/injection_container.dart';
import 'package:weather_app_test/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_test/features/weather/presentation/pages/weather_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => sl<WeatherBloc>(),
        child: WeatherPage(),
      ),
    );
  }
}
