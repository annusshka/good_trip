import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/bloc/audio_tour/audio_tour.dart';
import 'package:good_trip/core/presentation/bloc/tour_list/tour_list.dart';
import 'package:good_trip/di/configure_dependencies.dart';
import 'package:good_trip/features/welcome/data/repository/i_welcome_info_repository.dart';
import 'package:good_trip/features/welcome/presentation/bloc/welcome_info.dart';

@RoutePage()
class HomeWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TourListBloc>(
          lazy: false,
          create: (_) => TourListBloc(
            tourRepository: getIt.get<IApiTourRepository>(),
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
