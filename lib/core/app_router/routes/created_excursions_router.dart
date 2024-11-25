import 'package:auto_route/auto_route.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/app_router/routes/excursion_router.dart';

abstract class CreatedExcursionsRoutes {
  static final routes = AutoRoute(
    page: CreatedExcursionsWrapperRoute.page,
    children: [
      AutoRoute(
        page: CreatedExcursionsRoute.page,
        initial: true,
      ),
      ExcursionRoutes.routes,
    ],
  );
}
