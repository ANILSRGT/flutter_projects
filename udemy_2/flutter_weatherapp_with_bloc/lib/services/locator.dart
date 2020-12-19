import 'package:flutter_weatherapp_with_bloc/data/weather_api_client.dart';
import 'package:flutter_weatherapp_with_bloc/data/weather_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => WeatherRepository());
  locator.registerLazySingleton(() => WeatherApiClient());
}