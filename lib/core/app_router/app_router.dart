import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/core/app_router/tour_router.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/features/account/presentation/account_screen.dart';
import 'package:good_trip/features/account_list/presentation/account_list_screen.dart';
import 'package:good_trip/features/account_list/presentation/account_list_wrapper_screen.dart';
import 'package:good_trip/features/favorite/presentation/favorite_screen.dart';
import 'package:good_trip/features/favorite/presentation/favorite_wrapper_screen.dart';
import 'package:good_trip/features/home/presentation/home_screen.dart';
import 'package:good_trip/features/home/presentation/home_wrapper_screen.dart';
import 'package:good_trip/features/public_tours/presentation/created_tours_screen.dart';
import 'package:good_trip/features/public_tours/presentation/created_tours_wrapper_screen.dart';
import 'package:good_trip/features/sign_in/presentation/sign_in_screen.dart';
import 'package:good_trip/features/sign_up/presentation/sign_up_screen.dart';
import 'package:good_trip/features/splashscreen/presentation/splash_screen.dart';
import 'package:good_trip/features/tour/presentation/tour_screen.dart';
import 'package:good_trip/features/tour/presentation/tour_wrapper_screen.dart';
import 'package:good_trip/features/tour_create/presentation/tour_create_screen.dart';
import 'package:good_trip/features/tour_create_list/presentation/tour_create_list_screen.dart';
import 'package:good_trip/features/tour_create_list/presentation/tour_create_list_wrapper_screen.dart';
import 'package:good_trip/features/welcome/welcome_screen.dart';
import 'package:good_trip/features/welcome/welcome_wrapper_screen.dart';

import 'tour_create_router.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: WelcomeWrapperRoute.page,
          path: '/',
          children: [
            AutoRoute(page: WelcomeRoute.page, initial: true),
            AutoRoute(page: SignInRoute.page),
            AutoRoute(page: SignUpRoute.page),
            TourRoutes.routes,
            AutoRoute(page: TourCreateRoute.page),
            AutoRoute(
              page: NavBarUserRoute.page,
              children: [
                AutoRoute(
                  page: HomeWrapperRoute.page,
                  children: [
                    AutoRoute(page: HomeRoute.page, initial: true),
                    TourRoutes.routes,
                  ],
                ),
                AutoRoute(
                  page: FavoriteWrapperRoute.page,
                  children: [
                    AutoRoute(page: FavoriteRoute.page, initial: true),
                    TourRoutes.routes,
                  ],
                ),
                TourCreateRoutes.routes,
                AutoRoute(page: AccountRoute.page),
              ],
            ),
            AutoRoute(
              page: NavBarAdminRoute.page,
              children: [
                AutoRoute(
                  page: AccountListWrapperRoute.page,
                  children: [
                    AutoRoute(page: AccountListRoute.page, initial: true),
                  ],
                ),
                AutoRoute(
                  page: CreatedToursWrapperRoute.page,
                  children: [
                    AutoRoute(page: CreatedToursRoute.page, initial: true),
                    TourRoutes.routes,
                  ],
                ),
                AutoRoute(page: AccountRoute.page),
              ],
            ),
          ],
        ),
      ];
}
