// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AccountListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccountListScreen(),
      );
    },
    AccountListWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const AccountListWrapperScreen()),
      );
    },
    AccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccountScreen(),
      );
    },
    CreatedToursRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreatedToursScreen(),
      );
    },
    CreatedToursWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CreatedToursWrapperScreen()),
      );
    },
    FavoriteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoriteScreen(),
      );
    },
    FavoriteWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const FavoriteWrapperScreen()),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    HomeWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const HomeWrapperScreen()),
      );
    },
    NavBarAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const NavBarAdminScreen()),
      );
    },
    NavBarUserRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const NavBarUserScreen()),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInScreen(),
      );
    },
    SignUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    TourCreateListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TourCreateListScreen(),
      );
    },
    TourCreateListWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const TourCreateListWrapperScreen()),
      );
    },
    TourCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TourCreateScreen(),
      );
    },
    TourRoute.name: (routeData) {
      final args = routeData.argsAs<TourRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TourScreen(
          key: args.key,
          tour: args.tour,
        ),
      );
    },
    TourWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const TourWrapperScreen()),
      );
    },
  };
}

/// generated route for
/// [AccountListScreen]
class AccountListRoute extends PageRouteInfo<void> {
  const AccountListRoute({List<PageRouteInfo>? children})
      : super(
          AccountListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AccountListWrapperScreen]
class AccountListWrapperRoute extends PageRouteInfo<void> {
  const AccountListWrapperRoute({List<PageRouteInfo>? children})
      : super(
          AccountListWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountListWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AccountScreen]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute({List<PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreatedToursScreen]
class CreatedToursRoute extends PageRouteInfo<void> {
  const CreatedToursRoute({List<PageRouteInfo>? children})
      : super(
          CreatedToursRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreatedToursRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreatedToursWrapperScreen]
class CreatedToursWrapperRoute extends PageRouteInfo<void> {
  const CreatedToursWrapperRoute({List<PageRouteInfo>? children})
      : super(
          CreatedToursWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreatedToursWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoriteScreen]
class FavoriteRoute extends PageRouteInfo<void> {
  const FavoriteRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoriteWrapperScreen]
class FavoriteWrapperRoute extends PageRouteInfo<void> {
  const FavoriteWrapperRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeWrapperScreen]
class HomeWrapperRoute extends PageRouteInfo<void> {
  const HomeWrapperRoute({List<PageRouteInfo>? children})
      : super(
          HomeWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NavBarAdminScreen]
class NavBarAdminRoute extends PageRouteInfo<void> {
  const NavBarAdminRoute({List<PageRouteInfo>? children})
      : super(
          NavBarAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'NavBarAdminRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NavBarUserScreen]
class NavBarUserRoute extends PageRouteInfo<void> {
  const NavBarUserRoute({List<PageRouteInfo>? children})
      : super(
          NavBarUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'NavBarUserRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInScreen]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpScreen]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TourCreateListScreen]
class TourCreateListRoute extends PageRouteInfo<void> {
  const TourCreateListRoute({List<PageRouteInfo>? children})
      : super(
          TourCreateListRoute.name,
          initialChildren: children,
        );

  static const String name = 'TourCreateListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TourCreateListWrapperScreen]
class TourCreateListWrapperRoute extends PageRouteInfo<void> {
  const TourCreateListWrapperRoute({List<PageRouteInfo>? children})
      : super(
          TourCreateListWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'TourCreateListWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TourCreateScreen]
class TourCreateRoute extends PageRouteInfo<void> {
  const TourCreateRoute({List<PageRouteInfo>? children})
      : super(
          TourCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'TourCreateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TourScreen]
class TourRoute extends PageRouteInfo<TourRouteArgs> {
  TourRoute({
    Key? key,
    required ITour tour,
    List<PageRouteInfo>? children,
  }) : super(
          TourRoute.name,
          args: TourRouteArgs(
            key: key,
            tour: tour,
          ),
          initialChildren: children,
        );

  static const String name = 'TourRoute';

  static const PageInfo<TourRouteArgs> page = PageInfo<TourRouteArgs>(name);
}

class TourRouteArgs {
  const TourRouteArgs({
    this.key,
    required this.tour,
  });

  final Key? key;

  final ITour tour;

  @override
  String toString() {
    return 'TourRouteArgs{key: $key, tour: $tour}';
  }
}

/// generated route for
/// [TourWrapperScreen]
class TourWrapperRoute extends PageRouteInfo<void> {
  const TourWrapperRoute({List<PageRouteInfo>? children})
      : super(
          TourWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'TourWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
