import 'package:auto_route/auto_route.dart';

import 'app_router.dart';
import 'tour_router.dart';

abstract class TourCreateRoutes {
  static final routes = AutoRoute(
    page: TourCreateListWrapperRoute.page,
    children: [
      AutoRoute(
        page: TourCreateListRoute.page,
        initial: true,
      ),
      AutoRoute(
        page: TourCreateRoute.page,
      ),
      TourRoutes.routes,
    ],
  );
}
