import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/bloc/audio_tour/audio_tour.dart';
import 'package:good_trip/core/presentation/bloc/tour/tour.dart';
import 'package:good_trip/core/presentation/bloc/tour_list/tour_list.dart';
import 'package:good_trip/di/configure_dependencies.dart';

@RoutePage()
class TourWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const TourWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TourBloc>(
          lazy: false,
          create: (_) => TourBloc(
            tourRepository: getIt.get<ITourRepository>(),
          ),
        ),
        BlocProvider<TourListBloc>(
          lazy: false,
          create: (_) => TourListBloc(
            tourRepository: getIt.get<IApiTourRepository>(),
          )..add(
              const TourListRequested(lon: 38.364285, lat: 59.855685),
            ),
        ),
        BlocProvider<AudioTourBloc>(
          lazy: false,
          create: (_) => AudioTourBloc(
            tourRepository: getIt.get<ITourRepository>(),
          ),
        ),
      ],
      child: this,
    );
  }
}
