import 'package:auto_route/auto_route.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/app_router/routes/excursion_router.dart';
import 'package:good_trip/core/app_router/routes/home_router.dart';

abstract class FavouriteRoutes {
  static final routes = AutoRoute(
    page: FavoriteWrapperRoute.page,
    children: [
      AutoRoute(
        page: FavoriteRoute.page,
        initial: true,
      ),
      ExcursionRoutes.routes,
      HomeRoutes.routes,
    ],
  );
}
