import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/bloc/audio_excursion/audio_excursion.dart';
import 'package:good_trip/core/presentation/bloc/excursion_list/excursion_list.dart';
import 'package:good_trip/core/presentation/bloc/tour/tour.dart';
import 'package:good_trip/di/set_up_locator.dart';

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
        BlocProvider<ExcursionListBloc>(
          lazy: false,
          create: (_) => ExcursionListBloc(
            excursionRepository: getIt.get<IApiTourRepository>(),
          ),
        ),
        BlocProvider<AudioExcursionBloc>(
          lazy: false,
          create: (_) => AudioExcursionBloc(
            excursionRepository: getIt.get<IExcursionRepository>(),
          ),
        ),
        BlocProvider<TourBloc>(
          lazy: false,
          create: (_) => TourBloc(
            tourRepository: getIt.get<ITourRepository>(),
          ),
        ),
      ],
      child: this,
    );
  }
}
