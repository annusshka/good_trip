import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/bloc/bloc.dart';
import 'package:good_trip/di/set_up_locator.dart';

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
        BlocProvider<TourListBloc>(
          lazy: false,
          create: (_) => TourListBloc(tourRepository: getIt.get<ITourRepository>()),
        ),
      ],
      child: this,
    );
  }
}
