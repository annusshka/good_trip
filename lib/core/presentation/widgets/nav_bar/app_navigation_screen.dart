import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/weather/weather.dart';
import 'package:good_trip/core/presentation/widgets/nav_bar/nav_bar_element.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../app_router/app_router.dart';

@RoutePage()
class AppNavigationScreen extends StatelessWidget implements AutoRouteWrapper {
  const AppNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeWrapperRoute(),
        FavoriteRoute(),
        TourCreateListRoute(),
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
        BlocProvider<WeatherBloc>(lazy: false, create: (_) => WeatherBloc()),
        //BlocProvider<AuthBloc>(lazy: false, create: (_) => AuthBloc()),
      ],
      child: this,
    );
  }
}