import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/widgets/nav_bar/app_navigation_bar.dart';
import 'package:good_trip/core/theme/routes/routes.dart';
import 'package:good_trip/core/theme/theme.dart';

import 'core/data/repositories/service/auth_repository.dart';
import 'core/presentation/bloc/auth/auth_bloc.dart';
import 'features/sign_in/presentation/sign_in_screen.dart';

class GoodTripApp extends StatelessWidget {
  const GoodTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
            title: 'Good Trip',
            theme: mainTheme,
            routes: route,
            home: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                  if (snapshot.hasData) {
                    return const AppNavigationBar();
                  }
                  // Otherwise, they're not signed in. Show the sign in page.
                  return const SignIn();
                }),
        ),
      ),
    );
  }
}
/*
class GoodTripApp extends StatelessWidget {
  const GoodTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Good Trip',
      theme: mainTheme,
      routes: route,
    );
  }
}

 */