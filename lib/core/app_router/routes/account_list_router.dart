import 'package:auto_route/auto_route.dart';
import 'package:good_trip/core/app_router/app_router.dart';

abstract class AccountListRoutes {
  static final routes = AutoRoute(
    page: AccountListWrapperRoute.page,
    children: [
      AutoRoute(
        page: AccountListRoute.page,
        initial: true,
      ),
    ],
  );
}
