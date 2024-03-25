import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/nav_bar/navigation_bloc.dart';
import 'package:good_trip/core/presentation/widgets/nav_bar/navigation_bar.dart';
import 'package:good_trip/core/theme/theme.dart';
import 'package:good_trip/core/theme/routes/routes.dart';

import 'core/presentation/bloc/auth/auth_bloc.dart';
import 'core/presentation/bloc/auth/auth_state.dart';
import 'core/presentation/bloc/nav_bar/navigation_state.dart';
import 'features/sign_in/presentation/sign_in_screen.dart';

class GoodTripApp extends StatelessWidget {
  const GoodTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => AuthBloc())
      ],
      child: MaterialApp(
        title: 'Good Trip',
        theme: mainTheme,
        routes: route,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState || state is AuthUnauthenticatedState) {
              return const SignIn();
            } else {
              return BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
                  return const AppNavigationBar();
                },
              );
            }
          },
        ),
      ),
    );
  }
}