import 'package:auto_route/auto_route.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/app_router/routes/excursion_router.dart';
import 'package:good_trip/core/app_router/routes/map_router.dart';

abstract class TourRoutes {
  static final routes = AutoRoute(
    page: TourWrapperRoute.page,
    children: [
      AutoRoute(
        page: TourRoute.page,
        initial: true,
      ),
      ExcursionRoutes.routes,
      MapRoutes.routes,
    ],
  );
}