import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/data/repository/auth/i_auth_repository.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:good_trip/core/theme/strings.dart';
import 'package:good_trip/core/theme/theme.dart';
import 'package:good_trip/di/configure_dependencies.dart';

class GoodTripApp extends StatefulWidget {
  const GoodTripApp({super.key});

  @override
  State<GoodTripApp> createState() => _GoodTripAppState();
}

class _GoodTripAppState extends State<GoodTripApp> {
  final appRouter = getIt.get<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: goodTrip,
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AuthBloc>(
        lazy: false,
        create: (context) => AuthBloc(authRepository: getIt.get<IAuthRepository>(),),
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