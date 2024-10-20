import 'package:auto_route/auto_route.dart';

import 'app_router.dart';

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
