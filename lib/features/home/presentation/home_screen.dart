import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/audio_tour/audio_tour.dart';
import 'package:good_trip/core/presentation/bloc/tour_list/tour_list.dart';
import 'package:good_trip/core/presentation/bloc/weather/weather.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create.dart';

import 'widgets/geolocation.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLoadSuccess) {
              BlocProvider.of<TourListBloc>(context).add(
                TourListRequested(
                  city: state.weather.cityName,
                  lon: state.weather.lon,
                  lat: state.weather.lat,
                ),
              );
              BlocProvider.of<AudioTourBloc>(context).add(
                AudioTourRequested(
                  city: state.weather.cityName,
                  lon: state.weather.lon,
                  lat: state.weather.lat,
                ),
              );
            }
          },
        ),
        BlocListener<TourCreateBloc, TourCreateState>(
            listener: (context, state) {
          if (state is TourCreatedSuccess) {
            BlocProvider.of<AudioTourBloc>(context).add(
              const AudioTourRequested(),
            );
          }
        })
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          //backgroundColor: Colors.transparent,
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
                  delegate: MySearchDelegate(
                    (query) => BlocProvider.of<WeatherBloc>(context)
                      ..add(
                        WeatherRequested(city: query),
                      ),
                  ),
                );
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Популярные места',
                        style: AppTextTheme.semiBold18,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 15,
                      child: BlocBuilder<TourListBloc, TourListState>(
                        builder: (context, state) {
                          if (state is TourListLoadInProgress) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is TourListLoadSuccess) {
                            if (state.tourList.isEmpty) {
                              return const EmptyList();
                            }
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.tourList.length,
                              separatorBuilder: (BuildContext context, _) =>
                                  const SizedBox(
                                width: 10,
                              ),
                              itemBuilder: (context, i) {
                                final tour = state.tourList[i];
                                return TourScrollElement(
                                  tour: tour,
                                );
                              },
                            );
                          }
                          if (state is TourListLoadFailure) {
                            return const Center(
                              child: Text('Произошла ошибка при загрузке'),
                            );
                          }
                          return const Center();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Аудиоэкрскурсии',
                        style: AppTextTheme.semiBold18,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 15,
                      child: BlocBuilder<AudioTourBloc, AudioTourState>(
                        builder: (context, state) {
                          if (state is AudioTourLoadInProgress) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is AudioTourLoadSuccess) {
                            if (state.tourList.isEmpty) {
                              return const EmptyList();
                            }
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.tourList.length,
                              separatorBuilder: (BuildContext context, _) =>
                                  const SizedBox(
                                width: 10,
                              ),
                              itemBuilder: (context, i) {
                                final tour = state.tourList[i];
                                return TourScrollElement(
                                  tour: tour,
                                );
                              },
                            );
                          }
                          if (state is AudioTourLoadFailure) {
                            return const Center(
                              child: Text('Произошла ошибка при загрузке'),
                            );
                          }
                          return const Center();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
