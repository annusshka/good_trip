import 'package:auto_route/auto_route.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/app_router/routes/excursion_router.dart';

abstract class TourCreateRoutes {
  static final routes = AutoRoute(
    page: TourCreateWrapperRoute.page,
    children: [
      AutoRoute(
        page: TourCreateRoute.page,
        children: [
          AutoRoute(
            page: TourCreateExcursionWrapperRoute.page,
            children: [
              AutoRoute(page: TourCreateExcursionRoute.page),
            ],
          ),
        ],
      ),
      AutoRoute(page: TourCreateExcursionRoute.page),
      ExcursionRoutes.routes,
    ],
  );
}
