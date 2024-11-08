import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/bloc/excursion_create_list/excursion_create_list.dart';
import 'package:good_trip/core/presentation/bloc/tour_create_list/tour_create_list.dart';
import 'package:good_trip/di/configure_dependencies.dart';
import 'package:good_trip/features/excursion_create_list/presentation/bloc/tour_create.dart';

@RoutePage()
class ExcursionCreateListWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const ExcursionCreateListWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => ExcursionCreateListBloc(
            excursionRepository: getIt.get<IExcursionRepository>(),
          )..add(
              const ExcursionListCreateByActualUserRequested(),
            ),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => TourCreateListBloc(
            tourRepository: getIt.get<ITourRepository>(),
          )..add(
            const ToursCreateByActualUserRequested(),
          ),
        ),
        BlocProvider(
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
