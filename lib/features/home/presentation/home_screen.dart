import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/bloc/audio_tour/audio_tour.dart';
import '../../../core/presentation/bloc/tour/tour.dart';
import '../../../core/presentation/bloc/weather/weather.dart';
import '../../../core/presentation/widgets/widgets.dart';
import 'widgets/geolocation.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherLoadSuccess) {
          BlocProvider.of<TourBloc>(context).add(TourRequested(
              city: state.weather.cityName,
              lon: state.weather.lon,
              lat: state.weather.lat));
          BlocProvider.of<AudioTourBloc>(context).add(AudioTourRequested(
              city: state.weather.cityName,
              lon: state.weather.lon,
              lat: state.weather.lat));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title:
              BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
            if (state is WeatherLoadSuccess) {
              return Geolocation(
                locationInfo: state.weather,
              );
            } else {
              return const Center();
            }
          }),
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
                          ..add(WeatherRequested(city: query))));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                  height: 250,
                  child: BlocBuilder<TourBloc, TourState>(
                      builder: (context, state) {
                    if (state is AudioTourLoadInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is TourLoadSuccess && state.tourList.isNotEmpty) {
                      return TourScrollList(
                          tourList: state.tourList, title: 'Популярные места');
                    }
                    return const Center();
                  })),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  height: 250,
                  child: BlocBuilder<AudioTourBloc, AudioTourState>(
                      builder: (context, state) {
                    if (state is AudioTourLoadInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is AudioTourLoadSuccess &&
                        state.tourList.isNotEmpty) {
                      return TourScrollList(
                        tourList: state.tourList,
                        title: 'Аудиоэкскурсия',
                        icon: Icons.headphones_rounded,
                      );
                    }
                    return const Center();
                  })),
            ],
          ),
        ),
      ),
    );
  }
}
