import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/bloc/audio_tour/audio_tour.dart';
import 'package:good_trip/core/presentation/bloc/excursion/excursion.dart';
import 'package:good_trip/core/presentation/bloc/excursion_list/excursion_list.dart';
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
        BlocProvider<ExcursionBloc>(
          lazy: false,
          create: (_) => ExcursionBloc(
            excursionRepository: getIt.get<IExcursionRepository>(),
          ),
        ),
        BlocProvider<ExcursionListBloc>(
          lazy: false,
          create: (_) => ExcursionListBloc(
            excursionRepository: getIt.get<IApiTourRepository>(),
          )..add(
              const ExcursionListRequested(lon: 38.364285, lat: 59.855685),
            ),
        ),
        BlocProvider<AudioTourBloc>(
          lazy: false,
          create: (_) => AudioTourBloc(
            tourRepository: getIt.get<IExcursionRepository>(),
          ),
        ),
      ],
      child: this,
    );
  }
}
