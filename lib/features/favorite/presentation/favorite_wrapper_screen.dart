import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/bloc/tour/tour.dart';
import 'package:good_trip/di/set_up_locator.dart';
import 'package:good_trip/features/favorite/presentation/bloc/favorite_excursion_list/favorite_excursion_list.dart';
import 'package:good_trip/features/favorite/presentation/bloc/favorite_tour_list/favorite_tour_list.dart';

@RoutePage()
class FavoriteWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const FavoriteWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteExcursionListBloc>(
          lazy: false,
          create: (_) => FavoriteExcursionListBloc(excursionRepository: getIt.get<IExcursionRepository>())
            ..add(const FavoriteExcursionListRequested()),
        ),
        BlocProvider<FavoriteTourListBloc>(
          lazy: false,
          create: (_) => FavoriteTourListBloc(tourRepository: getIt.get<ITourRepository>())
            ..add(const FavoriteTourListRequested()),
        ),
        BlocProvider<TourBloc>(
          lazy: false,
          create: (_) => TourBloc(tourRepository: getIt.get<ITourRepository>()),
        ),
      ],
      child: this,
    );
  }
}
