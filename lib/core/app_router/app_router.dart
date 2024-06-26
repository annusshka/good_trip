import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/features/sign_up/presentation/sign_up_screen.dart';
import 'package:good_trip/features/splashscreen/presentation/splash_screen.dart';

import '../../features/account/presentation/account_screen.dart';
import '../../features/account_list/presentation/account_list_screen.dart';
import '../../features/favorite/presentation/favorite_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/home/presentation/home_wrapper_screen.dart';
import '../../features/public_tours/presentation/created_tours_screen.dart';
import '../../features/public_tours/presentation/created_tours_wrapper_screen.dart';
import '../../features/sign_in/presentation/sign_in_screen.dart';
import '../../features/tour/presentation/tour_screen.dart';
import '../../features/tour_create/presentation/tour_create_screen.dart';
import '../../features/tour_create_list/presentation/tour_create_list_screen.dart';
import '../../features/tour_create_list/presentation/tour_create_list_wrapper_screen.dart';
import '../domain/models/models.dart';
import '../presentation/widgets/nav_bar/nav_bar_admin_screen.dart';
import '../presentation/widgets/nav_bar/nav_bar_user_screen.dart';
import 'tour_create_router.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SignInRoute.page, path: '/'),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: TourRoute.page),
        AutoRoute(page: TourCreateRoute.page),
        AutoRoute(page: NavBarUserRoute.page, children: [
          AutoRoute(
            page: HomeWrapperRoute.page,
            children: [
              AutoRoute(page: HomeRoute.page, initial: true),
            ],
          ),
          AutoRoute(page: FavoriteRoute.page),
          TourCreateRoutes.routes,
          AutoRoute(page: AccountRoute.page),
        ]),
        AutoRoute(page: NavBarAdminRoute.page, children: [
          AutoRoute(page: AccountListRoute.page),
          AutoRoute(page: CreatedToursWrapperRoute.page, children: [
            AutoRoute(page: CreatedToursRoute.page, initial: true),
          ]),
          AutoRoute(page: AccountRoute.page),
        ]),
      ];
}
