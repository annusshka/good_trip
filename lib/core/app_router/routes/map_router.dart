import 'package:auto_route/auto_route.dart';
import 'package:good_trip/core/app_router/app_router.dart';

abstract class MapRoutes {
  static final routes = AutoRoute(
    page: MapWrapperRoute.page,
    children: [
      AutoRoute(
        page: MapRoute.page,
        initial: true,
      ),
    ],
  );
}