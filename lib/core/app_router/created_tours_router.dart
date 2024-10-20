import 'package:auto_route/auto_route.dart';

import 'app_router.dart';
import 'tour_router.dart';

abstract class CreatedToursRoutes {
  static final routes = AutoRoute(
    page: CreatedToursWrapperRoute.page,
    children: [
      AutoRoute(
        page: CreatedToursRoute.page,
        initial: true,
      ),
      TourRoutes.routes,
    ],
  );
}
