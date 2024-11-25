import 'package:auto_route/auto_route.dart';
import 'package:good_trip/core/app_router/app_router.dart';

abstract class ExcursionRoutes {
  static final routes = AutoRoute(
    page: ExcursionWrapperRoute.page,
    children: [
      AutoRoute(
        page: ExcursionRoute.page,
        initial: true,
      ),
    ],
  );
}
