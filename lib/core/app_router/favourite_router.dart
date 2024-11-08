import 'package:auto_route/auto_route.dart';

import 'app_router.dart';
import 'excursion_router.dart';

abstract class FavouriteRoutes {
  static final routes = AutoRoute(
    page: FavoriteWrapperRoute.page,
    children: [
      AutoRoute(
        page: FavoriteRoute.page,
        initial: true,
      ),
      ExcursionRoutes.routes,
    ],
  );
}
