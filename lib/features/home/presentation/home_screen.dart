import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/location_info.dart';
import 'package:good_trip/core/presentation/bloc/audio_excursion/audio_excursion.dart';
import 'package:good_trip/core/presentation/bloc/excursion_list/excursion_list.dart';
import 'package:good_trip/core/presentation/bloc/weather/weather.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';

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
              BlocProvider.of<ExcursionListBloc>(context).add(
                ExcursionListRequested(
                  city: state.weather.cityName,
                  lon: state.weather.lon,
                  lat: state.weather.lat,
                ),
              );
              BlocProvider.of<AudioExcursionBloc>(context).add(
                AudioExcursionRequested(
                  city: state.weather.cityName,
                  lon: state.weather.lon,
                  lat: state.weather.lat,
                ),
              );
            }
          },
        ),
        BlocListener<ExcursionCreateBloc, ExcursionCreateState>(listener: (context, state) {
          if (state is ExcursionCreatedSuccess) {
            BlocProvider.of<AudioExcursionBloc>(context).add(
              const AudioExcursionRequested(),
            );
          }
        }),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.white,
          ),
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoadSuccess) {
                return Geolocation(
                  locationInfo: state.weather,
                );
              } else if (state is WeatherLoadInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WeatherLoadFailure){
                return Geolocation(
                  locationInfo: state.weather ?? LocationInfo.undefined(),
                );
              } else {
                return Geolocation(
                  locationInfo: LocationInfo.undefined(),
                );
              }
            },
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
          padding: const EdgeInsets.all(16.0),
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
                      child: BlocBuilder<ExcursionListBloc, ExcursionListState>(
                        builder: (context, state) {
                          if (state is ExcursionListLoadInProgress) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (state is ExcursionListLoadSuccess) {
                            if (state.excursionList.isEmpty) {
                              return const EmptyList();
                            }
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.excursionList.length,
                              separatorBuilder: (BuildContext context, _) => const SizedBox(
                                width: 10,
                              ),
                              itemBuilder: (context, i) {
                                final tour = state.excursionList[i];
                                return ExcursionScrollElement(
                                  excursion: tour,
                                );
                              },
                            );
                          }
                          if (state is ExcursionListLoadFailure) {
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
                      child: BlocBuilder<AudioExcursionBloc, AudioExcursionState>(
                        builder: (context, state) {
                          if (state is AudioExcursionLoadInProgress) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is AudioExcursionLoadSuccess) {
                            if (state.tourList.isEmpty) {
                              return const EmptyList();
                            }
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.tourList.length,
                              separatorBuilder: (BuildContext context, _) => const SizedBox(
                                width: 10,
                              ),
                              itemBuilder: (context, i) {
                                final tour = state.tourList[i];
                                return ExcursionScrollElement(
                                  excursion: tour,
                                );
                              },
                            );
                          }
                          if (state is AudioExcursionLoadFailure) {
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
