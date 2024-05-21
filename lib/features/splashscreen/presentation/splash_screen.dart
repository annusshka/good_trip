import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';

import '../../../core/presentation/bloc/auth/auth.dart';
import '../../../core/presentation/widgets/widgets.dart';
import '../../../core/theme/theme.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return AnimatedSplashScreen(
      splash: const Logo(),
      splashIconSize: 300,
      backgroundColor: colors.pink_,
      duration: 5,
      nextScreen: BlocProvider<AuthBloc>(
        lazy: false,
        create: (_) => AuthBloc(),
        child: WillPopScope(
          onWillPop: () async => true,
          child: MaterialApp.router(
            theme: mainTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter.config(),
          ),
        ),
      ),
    );
  }
}
