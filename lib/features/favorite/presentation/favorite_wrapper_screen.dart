import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/di/configure_dependencies.dart';
import 'package:good_trip/features/favorite/presentation/bloc/favorite_list.dart';

import '../../../core/presentation/bloc/audio_tour/audio_tour.dart';
import '../../../core/presentation/bloc/tour_list/tour_list.dart';

@RoutePage()
class FavoriteWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const FavoriteWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<FavoriteListBloc>(
      create: (_) =>
      FavoriteListBloc(tourRepository: getIt.get<ITourRepository>())
        ..add(
          const FavoriteListRequested(),
        ),
      child: this,
    );
  }
}
