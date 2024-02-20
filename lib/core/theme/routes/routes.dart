import 'package:good_trip/core/presentation/widgets/nav_bar/app_navigation_bar.dart';
import 'package:good_trip/features/account/presentation/account_screen.dart';
import 'package:good_trip/features/favorite/presentation/favorite_screen.dart';
import 'package:good_trip/features/sign_in/presentation/sign_in_screen.dart';
import 'package:good_trip/features/sign_up/presentation/sign_up_screen.dart';
import 'package:good_trip/features/tour/tour_screen.dart';


final route = {
  '/app_nav': (context) => const AppNavigationBar(),
  '/sign_in': (context) => const SignIn(),
  '/sign_up': (context) => const SignUp(),
  '/tour_details': (context) => const TourScreen(),
  '/account': (context) => const AccountScreen(),
  '/favorite': (context) => const FavoriteScreen(),
};