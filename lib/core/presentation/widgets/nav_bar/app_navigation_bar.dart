import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth_bloc.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth_state.dart';
import 'package:good_trip/core/presentation/widgets/nav_bar/nav_bar_element.dart';
import 'package:good_trip/features/account/presentation/account_screen.dart';
import 'package:good_trip/features/favorite/presentation/favorite_screen.dart';
import 'package:good_trip/features/home/presentation/home_screen.dart';
import 'package:good_trip/features/sign_in/presentation/sign_in_screen.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          // Navigate to the sign in screen when the user Signs Out
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SignIn()),
                (route) => false,
          );
        }
      },
      child: Scaffold(
        body: Obx(() => controller.screens[controller.selectedIndex.value]),
        bottomNavigationBar: Obx(
              () => NavigationBar(
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                height: 70,
                elevation: 0,
                selectedIndex: controller.selectedIndex.value,
                indicatorColor: Colors.transparent,
                onDestinationSelected:
                    (index) => controller.selectedIndex.value = index,
                destinations: const [
                  NavBarElement(icon: Iconsax.home_1_copy),
                  NavBarElement(icon: Iconsax.heart_copy),
                  NavBarElement(icon: Iconsax.profile_circle_copy),
                  /*
                  NavigationDestination(
                    icon: Icon(
                      Iconsax.home_1_copy,
                      color: colors.lightGrayNavBar,
                      size: 24,
                    ),
                    selectedIcon:
                    const NavBarSelectedIcon(icon: Iconsax.home_1_copy),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Iconsax.heart_copy,
                      color: colors.lightGrayNavBar,
                      size: 24,
                    ),
                    selectedIcon:
                    const NavBarSelectedIcon(icon: Iconsax.heart_copy),
                    label: 'Favorite List',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Iconsax.profile_circle_copy,
                      color: colors.lightGrayNavBar,
                      size: 24,
                    ),
                    selectedIcon:
                    const NavBarSelectedIcon(icon: Iconsax.profile_circle_copy),
                    label: 'Account',
                  ),

                   */
                ],
              ),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const HomeScreen(), const FavoriteScreen(),
    const AccountScreen()];
}
