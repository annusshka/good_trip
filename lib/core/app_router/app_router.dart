import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/core/app_router/routes/account_list_router.dart';
import 'package:good_trip/core/app_router/routes/created_excursions_router.dart';
import 'package:good_trip/core/app_router/routes/excursion_router.dart';
import 'package:good_trip/core/app_router/routes/favourite_router.dart';
import 'package:good_trip/core/app_router/routes/tour_router.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/features/account/presentation/account_screen.dart';
import 'package:good_trip/features/account_list/presentation/account_list_screen.dart';
import 'package:good_trip/features/account_list/presentation/account_list_wrapper_screen.dart';
import 'package:good_trip/features/excursion/presentation/excursion_screen.dart';
import 'package:good_trip/features/excursion/presentation/excursion_wrapper_screen.dart';
import 'package:good_trip/features/excursion_create/presentation/excursion_create_screen.dart';
import 'package:good_trip/features/excursion_create/presentation/excursion_create_wrapper_screen.dart';
import 'package:good_trip/features/excursion_create_list/presentation/excursion_create_list_screen.dart';
import 'package:good_trip/features/excursion_create_list/presentation/excursion_create_list_wrapper_screen.dart';
import 'package:good_trip/features/favorite/presentation/favorite_screen.dart';
import 'package:good_trip/features/favorite/presentation/favorite_wrapper_screen.dart';
import 'package:good_trip/features/home/presentation/home_screen.dart';
import 'package:good_trip/features/home/presentation/home_wrapper_screen.dart';
import 'package:good_trip/features/public_excursions/presentation/created_excursions_screen.dart';
import 'package:good_trip/features/public_excursions/presentation/created_excursions_wrapper_screen.dart';
import 'package:good_trip/features/sign_in/presentation/sign_in_screen.dart';
import 'package:good_trip/features/sign_up/presentation/sign_up_screen.dart';
import 'package:good_trip/features/splashscreen/presentation/splash_screen.dart';
import 'package:good_trip/features/tour/tour_screen.dart';
import 'package:good_trip/features/tour/tour_wrapper_screen.dart';
import 'package:good_trip/features/tour_create/presentation/tour_create_excursion_screen.dart';
import 'package:good_trip/features/tour_create/presentation/tour_create_screen.dart';
import 'package:good_trip/features/tour_create/presentation/tour_create_wrapper_screen.dart';
import 'package:good_trip/features/welcome/welcome_screen.dart';
import 'package:good_trip/features/welcome/welcome_wrapper_screen.dart';

import 'routes/excursion_create_list_router.dart';
import 'routes/home_router.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: WelcomeWrapperRoute.page,
          children: [
            AutoRoute(
              page: WelcomeRoute.page,
              initial: true,
            ),
          ],
        ),
        AutoRoute(
          page: SignInRoute.page,
        ),
        AutoRoute(
          page: SignUpRoute.page,
        ),
        AutoRoute(
          page: NavBarUserRoute.page,
          children: [
            HomeRoutes.routes,
            ExcursionRoutes.routes,
            TourRoutes.routes,
            FavouriteRoutes.routes,
            ExcursionCreateListRoutes.routes,
            AutoRoute(
              page: AccountRoute.page,
            ),
          ],
        ),
        AutoRoute(
          page: NavBarAdminRoute.page,
          children: [
            AccountListRoutes.routes,
            CreatedExcursionsRoutes.routes,
            AutoRoute(
              page: AccountRoute.page,
            ),
          ],
        ),
      ];
}
