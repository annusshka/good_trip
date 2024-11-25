import 'package:auto_route/auto_route.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/app_router/routes/excursion_router.dart';

abstract class ExcursionCreateRoutes {
  static final routes = AutoRoute(
    page: ExcursionCreateWrapperRoute.page,
    children: [
      AutoRoute(
        page: ExcursionCreateRoute.page,
      ),
      ExcursionRoutes.routes,
    ],
  );
}
