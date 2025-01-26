import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/audio_player/data/audio_player_handler.dart';
import 'package:good_trip/core/audio_player/presentation/bloc/audio_player_cubit.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/bloc/audio_excursion/audio_excursion.dart';
import 'package:good_trip/core/presentation/bloc/excursion/excursion.dart';
import 'package:good_trip/core/presentation/bloc/excursion_list/excursion_list.dart';
import 'package:good_trip/di/set_up_locator.dart';

@RoutePage()
class ExcursionWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const ExcursionWrapperScreen({super.key});

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
        BlocProvider<AudioExcursionBloc>(
          lazy: false,
          create: (_) => AudioExcursionBloc(
            excursionRepository: getIt.get<IExcursionRepository>(),
          ),
        ),
        BlocProvider<AudioPlayerCubit>(
          lazy: false,
          create: (_) => AudioPlayerCubit(
            audioPlayerHandler: getIt.get<AudioPlayerHandler>(),
            audioHandler: getIt.get<AudioHandler>(),
          ),
        ),
      ],
      child: this,
    );
  }
}
