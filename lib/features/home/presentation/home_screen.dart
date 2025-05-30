import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/location_info.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/bloc.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
              BlocProvider.of<AudioExcursionListBloc>(context).add(
                AudioExcursionListRequested(
                  city: state.weather.cityName,
                  lon: state.weather.lon,
                  lat: state.weather.lat,
                ),
              );
              BlocProvider.of<TourListBloc>(context).add(
                TourListRequested(
                  city: state.weather.cityName,
                  lon: state.weather.lon,
                  lat: state.weather.lat,
                ),
              );
            }
            if (state is WeatherLoadFailure) {
              BlocProvider.of<ExcursionListBloc>(context).add(
                ExcursionListRequested(
                  city: state.weather.cityName,
                  lon: state.weather.lon,
                  lat: state.weather.lat,
                ),
              );
              BlocProvider.of<AudioExcursionListBloc>(context).add(
                AudioExcursionListRequested(
                  city: state.weather.cityName,
                  lon: state.weather.lon,
                  lat: state.weather.lat,
                ),
              );
              BlocProvider.of<TourListBloc>(context).add(
                TourListRequested(
                  city: state.weather.cityName,
                  lon: state.weather.lon,
                  lat: state.weather.lat,
                ),
              );
            }
          },
        ),
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
                return const GeolocationLoading();
              } else if (state is WeatherLoadFailure) {
                return Geolocation(
                  locationInfo: state.weather,
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
                    (query) => BlocProvider.of<WeatherBloc>(context)..add(WeatherRequested(city: query)),
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
                          return const EmptyListWidget();
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
                      child: BlocBuilder<AudioExcursionListBloc, AudioExcursionListState>(
                        builder: (context, state) {
                          if (state is AudioExcursionListLoadSuccess) {
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
                          if (state is AudioExcursionListLoadFailure) {
                            return const Center(
                              child: Text('Произошла ошибка при загрузке'),
                            );
                          }
                          return const EmptyListWidget();
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
                        'Аудиотуры',
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
                          if (state is TourListLoadSuccess) {
                            if (state.tourList.isEmpty) {
                              return const EmptyList();
                            }
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.tourList.length,
                              separatorBuilder: (BuildContext context, _) => const SizedBox(width: 10),
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
                          return const EmptyListWidget();
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

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 248,
            width: 150,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Center(
                    child: Bone(
                      width: 150.0,
                      height: 110,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${TourType.interesting_places}',
                            maxLines: 1,
                            style: AppTextTheme.medium10.copyWith(
                              color: AppColors.lightGray,
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 4,
                          child: Text(
                            'Название экскурсии Название экскурсии Название экскурсии Название экскурсии',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextTheme.semiBold18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 10,
        ),
      ),
    );
  }
}
