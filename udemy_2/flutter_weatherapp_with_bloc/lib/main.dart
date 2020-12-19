import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weatherapp_with_bloc/services/locator.dart';
import 'package:flutter_weatherapp_with_bloc/widgets/weather_app.dart';

import 'blocs/theme/bloc/theme_bloc.dart';
import 'blocs/weather/bloc/weather_bloc.dart';

void main() {
  setupLocator();
  runApp(BlocProvider<ThemeBloc>(
    create: (context) => ThemeBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, ThemeState state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: (state as UygulamaTemasi).tema,
          home: BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(),
            child: WeatherApp(),
          ),
        );
      },
    );
  }
}
