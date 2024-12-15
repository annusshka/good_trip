import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/di/set_up_locator.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create/tour_create.dart';

@RoutePage()
class TourCreateWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const TourCreateWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TourCreateBloc>(
          lazy: false,
          create: (_) => TourCreateBloc(
            tourRepository: getIt.get<ITourRepository>(),
          ),
        ),
      ],
      child: this,
    );
  }
}