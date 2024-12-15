import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/di/set_up_locator.dart';
import 'package:good_trip/features/welcome/data/repository/i_welcome_info_repository.dart';
import 'package:good_trip/features/welcome/presentation/bloc/welcome_info.dart';

@RoutePage()
class WelcomeWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const WelcomeWrapperScreen({super.key});

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
          create: (_) => WelcomeInfoBloc(
            welcomeInfoRepository: getIt.get<IWelcomeInfoRepository>(),
          )..add(const CheckFirstRun()),
        ),
      ],
      child: this,
    );
  }
}