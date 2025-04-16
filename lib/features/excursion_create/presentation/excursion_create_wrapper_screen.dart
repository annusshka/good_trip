import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/di/set_up_locator.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';

@RoutePage()
class ExcursionCreateWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const ExcursionCreateWrapperScreen({super.key});

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
      ],
      child: this,
    );
  }
}
