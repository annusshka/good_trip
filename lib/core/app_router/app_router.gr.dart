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
    CreatedExcursionsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreatedExcursionsScreen(),
      );
    },
    CreatedExcursionsWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CreatedExcursionsWrapperScreen()),
      );
    },
    ExcursionCreateListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExcursionCreateListScreen(),
      );
    },
    ExcursionCreateListWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const ExcursionCreateListWrapperScreen()),
      );
    },
    ExcursionCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExcursionCreateScreen(),
      );
    },
    ExcursionCreateWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const ExcursionCreateWrapperScreen()),
      );
    },
    ExcursionRoute.name: (routeData) {
      final args = routeData.argsAs<ExcursionRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ExcursionScreen(
          key: args.key,
          excursion: args.excursion,
        ),
      );
    },
    ExcursionWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const ExcursionWrapperScreen()),
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
    MapRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MapScreen(),
      );
    },
    MapWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const MapWrapperScreen()),
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
    TourCreateExcursionRoute.name: (routeData) {
      final args = routeData.argsAs<TourCreateExcursionRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TourCreateExcursionScreen(
          key: args.key,
          name: args.name,
          description: args.description,
          address: args.address,
          kinds: args.kinds,
          weekdays: args.weekdays,
          imagePath: args.imagePath,
          imageFile: args.imageFile,
        ),
      );
    },
    TourCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TourCreateScreen(),
      );
    },
    TourCreateWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const TourCreateWrapperScreen()),
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
    WelcomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomeScreen(),
      );
    },
    WelcomeWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const WelcomeWrapperScreen()),
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
/// [CreatedExcursionsScreen]
class CreatedExcursionsRoute extends PageRouteInfo<void> {
  const CreatedExcursionsRoute({List<PageRouteInfo>? children})
      : super(
          CreatedExcursionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreatedExcursionsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreatedExcursionsWrapperScreen]
class CreatedExcursionsWrapperRoute extends PageRouteInfo<void> {
  const CreatedExcursionsWrapperRoute({List<PageRouteInfo>? children})
      : super(
          CreatedExcursionsWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreatedExcursionsWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExcursionCreateListScreen]
class ExcursionCreateListRoute extends PageRouteInfo<void> {
  const ExcursionCreateListRoute({List<PageRouteInfo>? children})
      : super(
          ExcursionCreateListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExcursionCreateListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExcursionCreateListWrapperScreen]
class ExcursionCreateListWrapperRoute extends PageRouteInfo<void> {
  const ExcursionCreateListWrapperRoute({List<PageRouteInfo>? children})
      : super(
          ExcursionCreateListWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExcursionCreateListWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExcursionCreateScreen]
class ExcursionCreateRoute extends PageRouteInfo<void> {
  const ExcursionCreateRoute({List<PageRouteInfo>? children})
      : super(
          ExcursionCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExcursionCreateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExcursionCreateWrapperScreen]
class ExcursionCreateWrapperRoute extends PageRouteInfo<void> {
  const ExcursionCreateWrapperRoute({List<PageRouteInfo>? children})
      : super(
          ExcursionCreateWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExcursionCreateWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExcursionScreen]
class ExcursionRoute extends PageRouteInfo<ExcursionRouteArgs> {
  ExcursionRoute({
    Key? key,
    required IExcursion excursion,
    List<PageRouteInfo>? children,
  }) : super(
          ExcursionRoute.name,
          args: ExcursionRouteArgs(
            key: key,
            excursion: excursion,
          ),
          initialChildren: children,
        );

  static const String name = 'ExcursionRoute';

  static const PageInfo<ExcursionRouteArgs> page =
      PageInfo<ExcursionRouteArgs>(name);
}

class ExcursionRouteArgs {
  const ExcursionRouteArgs({
    this.key,
    required this.excursion,
  });

  final Key? key;

  final IExcursion excursion;

  @override
  String toString() {
    return 'ExcursionRouteArgs{key: $key, excursion: $excursion}';
  }
}

/// generated route for
/// [ExcursionWrapperScreen]
class ExcursionWrapperRoute extends PageRouteInfo<void> {
  const ExcursionWrapperRoute({List<PageRouteInfo>? children})
      : super(
          ExcursionWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExcursionWrapperRoute';

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
/// [MapScreen]
class MapRoute extends PageRouteInfo<void> {
  const MapRoute({List<PageRouteInfo>? children})
      : super(
          MapRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MapWrapperScreen]
class MapWrapperRoute extends PageRouteInfo<void> {
  const MapWrapperRoute({List<PageRouteInfo>? children})
      : super(
          MapWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapWrapperRoute';

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
/// [TourCreateExcursionScreen]
class TourCreateExcursionRoute
    extends PageRouteInfo<TourCreateExcursionRouteArgs> {
  TourCreateExcursionRoute({
    Key? key,
    required String name,
    required String description,
    required Address address,
    required List<String> kinds,
    required List<DayInWeek> weekdays,
    required String imagePath,
    required File? imageFile,
    List<PageRouteInfo>? children,
  }) : super(
          TourCreateExcursionRoute.name,
          args: TourCreateExcursionRouteArgs(
            key: key,
            name: name,
            description: description,
            address: address,
            kinds: kinds,
            weekdays: weekdays,
            imagePath: imagePath,
            imageFile: imageFile,
          ),
          initialChildren: children,
        );

  static const String name = 'TourCreateExcursionRoute';

  static const PageInfo<TourCreateExcursionRouteArgs> page =
      PageInfo<TourCreateExcursionRouteArgs>(name);
}

class TourCreateExcursionRouteArgs {
  const TourCreateExcursionRouteArgs({
    this.key,
    required this.name,
    required this.description,
    required this.address,
    required this.kinds,
    required this.weekdays,
    required this.imagePath,
    required this.imageFile,
  });

  final Key? key;

  final String name;

  final String description;

  final Address address;

  final List<String> kinds;

  final List<DayInWeek> weekdays;

  final String imagePath;

  final File? imageFile;

  @override
  String toString() {
    return 'TourCreateExcursionRouteArgs{key: $key, name: $name, description: $description, address: $address, kinds: $kinds, weekdays: $weekdays, imagePath: $imagePath, imageFile: $imageFile}';
  }
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
/// [TourCreateWrapperScreen]
class TourCreateWrapperRoute extends PageRouteInfo<void> {
  const TourCreateWrapperRoute({List<PageRouteInfo>? children})
      : super(
          TourCreateWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'TourCreateWrapperRoute';

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

/// generated route for
/// [WelcomeScreen]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WelcomeWrapperScreen]
class WelcomeWrapperRoute extends PageRouteInfo<void> {
  const WelcomeWrapperRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
