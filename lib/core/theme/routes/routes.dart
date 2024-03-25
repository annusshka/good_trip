import 'package:good_trip/features/account/presentation/account_screen.dart';
import 'package:good_trip/features/favorite/presentation/favorite_screen.dart';
import 'package:good_trip/features/home/presentation/home_screen.dart';
import 'package:good_trip/features/sign_in/presentation/sign_in_screen.dart';
import 'package:good_trip/features/sign_up/presentation/sign_up_screen.dart';
import 'package:good_trip/features/tour/tour_screen.dart';


final route = {
  '/home': (context) => const HomeScreen(),
  '/sign_in': (context) => const SignIn(),
  '/sign_up': (context) => const SignUp(),
  '/tour_details': (context) => const TourScreen(),
  '/account': (context) => const AccountScreen(),
  '/favorite': (context) => const FavoriteScreen(),
};