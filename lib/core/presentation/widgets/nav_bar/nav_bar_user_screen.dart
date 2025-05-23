import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/data/repository/weather/i_weather_repository.dart';
import 'package:good_trip/core/presentation/bloc/bloc.dart';
import 'package:good_trip/core/presentation/widgets/nav_bar/nav_bar_element.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/di/set_up_locator.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create/tour_create.dart';
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
        ExcursionCreateListWrapperRoute(),
        AccountRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          backgroundColor: AppColors.white,
          bottomNavigationBar: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            height: 70,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedIndex: tabsRouter.activeIndex,
            indicatorColor: Colors.transparent,
            onDestinationSelected: (index) => _openPage(index, tabsRouter),
            destinations: [
              const NavBarElement(icon: Iconsax.home_1_copy),
              const NavBarElement(icon: Iconsax.heart_copy),
              const NavBarElement(icon: Icons.public_outlined),
              const NavBarElement(icon: Iconsax.profile_circle_copy),
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
        BlocProvider<FavouriteExcursionCubit>(
          lazy: false,
          create: (_) => FavouriteExcursionCubit(
            excursionRepository: getIt.get<IExcursionRepository>(),
          )..favouriteAudioExcursionsRequested(),
        ),
        BlocProvider<FavouriteTourCubit>(
          lazy: false,
          create: (_) => FavouriteTourCubit(
            tourRepository: getIt.get<ITourRepository>(),
          )..favouriteTourListRequested(),
        ),
        BlocProvider<TourCreateBloc>(
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
