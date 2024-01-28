import 'package:good_trip/core/presentation/widgets/app_navigation_bar.dart';
import 'package:good_trip/features/account/presentation/account_screen.dart';
import 'package:good_trip/features/home/presentation/home_screen.dart';
import 'package:good_trip/features/tour/tour_screen.dart';

final route = {
  '/': (context) => const AppNavigationBar(),
  '/event': (context) => const TourScreen(),
  '/account': (context) => const AccountScreen(),
};