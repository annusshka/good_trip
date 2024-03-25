import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/widgets/nav_bar/nav_bar_element.dart';
import 'package:good_trip/features/account/presentation/account_screen.dart';
import 'package:good_trip/features/favorite/presentation/favorite_screen.dart';
import 'package:good_trip/features/home/presentation/home_screen.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../bloc/nav_bar/navigation_bloc.dart';
import '../../bloc/nav_bar/navigation_event.dart';
import '../../bloc/nav_bar/navigation_state.dart';

final screens = [const HomeScreen(), const FavoriteScreen(),
  const AccountScreen()];

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(child: screens.elementAt(state.tabIndex)),
          bottomNavigationBar: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            height: 70,
            elevation: 0,
            selectedIndex: state.tabIndex,
            indicatorColor: Colors.transparent,
            onDestinationSelected: (index) {
              BlocProvider.of<NavigationBloc>(context)
                  .add(TabChange(tabIndex: index));
            },
            destinations: const [
              NavBarElement(icon: Iconsax.home_1_copy),
              NavBarElement(icon: Iconsax.heart_copy),
              NavBarElement(icon: Iconsax.profile_circle_copy),
            ],
          ),
        );
      },
    );
  }
}

/*
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticatedState) {
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
*/