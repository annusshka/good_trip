import 'package:auto_route/auto_route.dart';

import 'app_router.dart';

abstract class TourRoutes {
  static final routes = AutoRoute(
    page: TourWrapperRoute.page,
    children: [
      AutoRoute(
        page: TourRoute.page,
        initial: true,
      ),
    ],
  );
}
