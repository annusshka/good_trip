import 'package:auto_route/auto_route.dart';

import 'app_router.dart';
import 'excursion_router.dart';

abstract class ExcursionCreateRoutes {
  static final routes = AutoRoute(
    page: ExcursionCreateListWrapperRoute.page,
    children: [
      AutoRoute(
        page: ExcursionCreateListRoute.page,
        initial: true,
      ),
      AutoRoute(
        page: ExcursionCreateRoute.page,
      ),
      ExcursionRoutes.routes,
    ],
  );
}
