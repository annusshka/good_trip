import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/bloc/tour_create_list/tour_create_list.dart';

@RoutePage()
class TourCreateListWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const TourCreateListWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          lazy: false,
          create: (_) =>
          TourCreateListBloc()..add(const TourListCreateByActualUserRequested())),
    ], child: this);
  }
}
