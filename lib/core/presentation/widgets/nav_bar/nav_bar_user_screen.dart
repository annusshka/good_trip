import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/data/repository/weather/i_weather_repository.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:good_trip/core/presentation/bloc/tour/tour.dart';
import 'package:good_trip/core/presentation/bloc/weather/weather.dart';
import 'package:good_trip/core/presentation/widgets/nav_bar/nav_bar_element.dart';
import 'package:good_trip/di/configure_dependencies.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

@RoutePage()
class NavBarUserScreen extends StatelessWidget implements AutoRouteWrapper {
  const NavBarUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeWrapperRoute(),
        FavoriteRoute(),
        TourCreateListWrapperRoute(),
        AccountRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            height: 70,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedIndex: tabsRouter.activeIndex,
            indicatorColor: Colors.transparent,
            onDestinationSelected: (index) => _openPage(index, tabsRouter),
            destinations: const [
              NavBarElement(icon: Iconsax.home_1_copy),
              NavBarElement(icon: Iconsax.heart_copy),
              NavBarElement(icon: Icons.file_upload_outlined),
              NavBarElement(icon: Iconsax.profile_circle_copy),
            ],
          ),
        );
      },
    );
  }

  void _openPage(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          lazy: false,
          create: (_) => WeatherBloc(
            weatherRepository: getIt.get<IWeatherRepository>(),
          )..add(const WeatherCurrentPositionRequested()),
        ),
        BlocProvider<TourBloc>(
          lazy: false,
          create: (_) => TourBloc(
            tourRepository: getIt.get<ITourRepository>(),
          ),
        ),
        BlocProvider<TourCreateBloc>(
          lazy: false,
          create: (_) => TourCreateBloc(
            tourRepository: getIt.get<ITourRepository>(),
          ),
        ),
        BlocProvider<AuthBloc>(
          lazy: false,
          create: (_) => AuthBloc(
            authRepository: getIt.get<IAuthRepository>(),
          ),
        ),
      ],
      child: this,
    );
  }
}
