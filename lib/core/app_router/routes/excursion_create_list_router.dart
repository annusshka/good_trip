import 'package:auto_route/auto_route.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/app_router/routes/excursion_create_router.dart';
import 'package:good_trip/core/app_router/routes/excursion_router.dart';
import 'package:good_trip/core/app_router/routes/tour_create_router.dart';
import 'package:good_trip/core/app_router/routes/tour_router.dart';

abstract class ExcursionCreateListRoutes {
  static final routes = AutoRoute(
    page: ExcursionCreateListWrapperRoute.page,
    children: [
      AutoRoute(
        page: ExcursionCreateListRoute.page,
        initial: true,
      ),
      ExcursionCreateRoutes.routes,
      TourCreateRoutes.routes,
      TourRoutes.routes,
      ExcursionRoutes.routes,
    ],
  );
}
