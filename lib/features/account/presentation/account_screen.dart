import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/account/presentation/widgets/profile_info.dart';
import 'package:good_trip/features/account/presentation/widgets/profile_settings_list.dart';

@RoutePage()
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthenticatedState) {
              return ProfileInfo(user: state.user);
            }
            return const Center();
          }),
          ListView(
            shrinkWrap: true,
            children: [
              const ProfileSettingsList(
                title: 'Поддержка',
                elementList: ['Связаться с поддержкой', 'Privacy policy'],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Другое',
                    style: AppTextTheme.semiBold18,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(LogOutRequested());
                        // AutoRouter.of(context).push(const SignInRoute());
                        // AutoRouter.of(context)
                        //     .replaceAll([const SignInRoute()]);
                        context.router.replaceAll([const SignInRoute()]);
                      },
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return const Text(
                            'Выйти',
                            style: AppTextTheme.normal16,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
