import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weatherapp_with_bloc/blocs/weather/bloc/weather_bloc.dart';

class MaxVeMinSicaklikWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Maksimum : " +
                  (state as WeatherLoadedState).weather.consolidatedWeather[0].maxTemp.floor().toString() +
                  " °C",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Minimum : " +
                  (state as WeatherLoadedState).weather.consolidatedWeather[0].minTemp.floor().toString() +
                  " °C",
              style: TextStyle(fontSize: 20),
            ),
          ],
        );
      },
    );
  }
}
