import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weatherapp_with_bloc/data/weather_repository.dart';
import 'package:flutter_weatherapp_with_bloc/models/weather.dart';
import 'package:flutter_weatherapp_with_bloc/services/locator.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository = locator<WeatherRepository>();

  WeatherBloc() : super(WeatherInitialState());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherLoadingState();
      try {
        final Weather weather = await weatherRepository.getWeather(event.sehirAdi);
        yield WeatherLoadedState(weather: weather);
      } catch (e) {
        yield WeatherErrorState();
      }
    } else if (event is RefreshWeatherEvent) {
      try {
        final Weather weather = await weatherRepository.getWeather(event.sehirAdi);
        yield WeatherLoadedState(weather: weather);
      } catch (e) {
        yield state; //current state
      }
    }
  }
}
