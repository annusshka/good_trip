import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/bloc/audio_tour/audio_tour.dart';
import '../../../core/presentation/bloc/tour/tour.dart';
import '../../../core/presentation/bloc/weather/weather.dart';

@RoutePage()
class HomeWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<WeatherBloc>(
        lazy: false,
        create: (_) =>
            WeatherBloc()..add(const WeatherCurrentPositionRequested()),
      ),
      BlocProvider<TourBloc>(
        lazy: false,
        create: (_) => TourBloc(),
      ),
      BlocProvider<AudioTourBloc>(
        lazy: false,
        create: (_) => AudioTourBloc(),
      ),
    ], child: this);
  }
}
