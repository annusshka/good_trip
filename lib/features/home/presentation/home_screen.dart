import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/tour/tour_event.dart';
import 'package:good_trip/core/presentation/bloc/weather/weather_event.dart';
import 'package:good_trip/core/presentation/bloc/weather/weather_state.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';

import '../../../core/presentation/bloc/tour/tour_bloc.dart';
import '../../../core/presentation/bloc/tour/tour_state.dart';
import '../../../core/presentation/bloc/weather/weather_bloc.dart';
import 'widgets/geolocation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          lazy: false,
          create: (context) => WeatherBloc()
            ..add(const WeatherCurrentPositionRequested()),
        ),
        BlocProvider<TourBloc>(
          lazy: false,
          create: (context) => TourBloc(),
        ),
      ],
      child: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherLoadSuccess) {
            BlocProvider.of<TourBloc>(context)
                .add(TourRequested(city: state.weather.cityName,
                lon: state.weather.lon, lat: state.weather.lat));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoadSuccess) {
                    return Geolocation(locationInfo: state.weather,);
                  } else {
                    return const Center();
                  }
                }
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search_rounded,
                  size: 24,
                  color: Colors.black,
                ),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: MySearchDelegate((query) =>
                      BlocProvider.of<WeatherBloc>(context)
                        ..add(WeatherRequested(city: query)))
                  );
                },
              ),
            ],
          ),
          body: BlocBuilder<TourBloc, TourState>(
            builder: (context, state) {
              if (state is TourLoadSuccess && state.tourList.isNotEmpty) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TourScrollList(
                            tourList: state.tourList,
                            title: 'Популярные места'
                        ),
                        TourScrollList(
                          tourList: state.tourList,
                          title: 'Аудиоэкскурсия',
                          icon: Icons.headphones_rounded,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator(),);
              }
            }
          ),
        ),
      ),
    );
  }
}
