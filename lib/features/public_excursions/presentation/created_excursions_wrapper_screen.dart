import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/bloc/excursion_create_list/excursion_create_list.dart';
import 'package:good_trip/di/configure_dependencies.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';

@RoutePage()
class CreatedExcursionsWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const CreatedExcursionsWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExcursionCreateBloc>(
          lazy: false,
          create: (_) => ExcursionCreateBloc(
            excursionRepository: getIt.get<IExcursionRepository>(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => ExcursionCreateListBloc(
            excursionRepository: getIt.get<IExcursionRepository>(),
          )..add(
              const ExcursionCreateListRequested(),
            ),
        ),
      ],
      child: this,
    );
  }
}
