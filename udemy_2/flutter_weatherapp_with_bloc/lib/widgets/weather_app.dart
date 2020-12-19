import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weatherapp_with_bloc/blocs/theme/bloc/theme_bloc.dart';
import 'package:flutter_weatherapp_with_bloc/blocs/weather/bloc/weather_bloc.dart';
import 'package:flutter_weatherapp_with_bloc/widgets/sehir_sec.dart';

import 'gecisli_arkaplan_renk.dart';
import 'hava_durumu_resim.dart';
import 'location.dart';
import 'max_ve_min_sicaklik.dart';
import 'son_guncelleme.dart';

// ignore: must_be_immutable
class WeatherApp extends StatelessWidget {
  String kullanicininSectigiSehir = "Ankara";
  Completer<RefreshIndicator> _refreshCompleter = Completer<RefreshIndicator>();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              kullanicininSectigiSehir =
                  await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SehirSecWidget()));
              if (kullanicininSectigiSehir != null) {
                _weatherBloc.add(FetchWeatherEvent(sehirAdi: kullanicininSectigiSehir));
              }
            },
          ),
        ],
      ),
      body: BlocBuilder(
        cubit: _weatherBloc,
        // ignore: missing_return
        builder: (context, WeatherState state) {
          if (state is WeatherInitialState) {
            return Center(
              child: Text("Şehir Seçiniz"),
            );
          }

          if (state is WeatherLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is WeatherLoadedState) {
            final getirilenWeather = state.weather;
            final havaDurumuKisaltma = getirilenWeather.consolidatedWeather[0].weatherStateAbbr;
            kullanicininSectigiSehir = getirilenWeather.title;

            BlocProvider.of<ThemeBloc>(context).add(TemaDegistirEvent(havaDurumuKisaltmasi: havaDurumuKisaltma));

            _refreshCompleter.complete();
            _refreshCompleter = Completer<RefreshIndicator>();

            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return GecisliArkaplanContainer(
                  renk: (state as UygulamaTemasi).renk,
                  child: RefreshIndicator(
                    onRefresh: () {
                      _weatherBloc.add(RefreshWeatherEvent(sehirAdi: kullanicininSectigiSehir));
                      return _refreshCompleter.future;
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: LocationWidget(
                                  secilenSehir: getirilenWeather.title,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SonGuncellemeWidget(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: HavaDurumuResimWidget(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: MaxVeMinSicaklikWidget(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state is WeatherErrorState) {
            return Center(
              child: Text("Hata Oluştu!"),
            );
          }
        },
      ),
    );
  }
}
