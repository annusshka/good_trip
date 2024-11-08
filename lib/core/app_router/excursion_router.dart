import 'package:auto_route/auto_route.dart';

import 'app_router.dart';

abstract class ExcursionRoutes {
  static final routes = AutoRoute(
    page: TourWrapperRoute.page,
    children: [
      AutoRoute(
        page: ExcursionRoute.page,
        initial: true,
      ),
    ],
  );
}
