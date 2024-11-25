import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/data/repository/repository.dart';
import 'package:good_trip/core/presentation/bloc/excursion/excursion.dart';
import 'package:good_trip/core/presentation/bloc/excursion_create_list/excursion_create_list.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/di/configure_dependencies.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'nav_bar_element.dart';

@RoutePage()
class NavBarAdminScreen extends StatelessWidget implements AutoRouteWrapper {
  const NavBarAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        AccountListRoute(),
        CreatedExcursionsWrapperRoute(),
        AccountRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          backgroundColor: AppColors.white,
          bottomNavigationBar: NavigationBar(
            backgroundColor: Colors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            height: 70,
            elevation: 0,
            selectedIndex: tabsRouter.activeIndex,
            indicatorColor: Colors.transparent,
            onDestinationSelected: (index) => _openPage(index, tabsRouter),
            destinations: const [
              NavBarElement(icon: Iconsax.user_copy),
              NavBarElement(icon: Icons.public),
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
        BlocProvider<ExcursionBloc>(
          lazy: false,
          create: (_) => ExcursionBloc(
            excursionRepository: getIt.get<IExcursionRepository>(),
          ),
        ),
        BlocProvider<ExcursionCreateListBloc>(
          lazy: false,
          create: (_) => ExcursionCreateListBloc(
            excursionRepository: getIt.get<IExcursionRepository>(),
          ),
        ),
      ],
      child: this,
    );
  }
}
