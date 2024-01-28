import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_trip/core/presentation/widgets/nav_bar_selected_icon.dart';
import 'package:good_trip/core/theme/theme.dart';
import 'package:good_trip/features/account/presentation/account_screen.dart';
import 'package:good_trip/features/home/presentation/home_screen.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
            () => NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              height: 70,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              indicatorColor: Colors.transparent,
              /*
              indicatorShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))
              ),

               */
              onDestinationSelected:
                  (index) => controller.selectedIndex.value = index,
              destinations: [
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
                    Iconsax.profile_circle_copy,
                    color: colors.lightGrayNavBar,
                    size: 24,
                  ),
                  selectedIcon:
                  const NavBarSelectedIcon(icon: Iconsax.profile_circle_copy),
                  label: 'Account',
                ),
              ],
            ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const HomeScreen(), const AccountScreen()
  ];
}
