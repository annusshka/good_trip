import 'package:auto_route/auto_route.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/app_router/routes/excursion_create_router.dart';
import 'package:good_trip/core/app_router/routes/excursion_router.dart';
import 'package:good_trip/core/app_router/routes/tour_router.dart';

abstract class HomeRoutes {
  static final routes = AutoRoute(
    page: HomeWrapperRoute.page,
    children: [
      AutoRoute(
        page: HomeRoute.page,
        initial: true,
      ),
      ExcursionRoutes.routes,
      ExcursionCreateRoutes.routes,
      TourRoutes.routes,
    ],
  );
}
