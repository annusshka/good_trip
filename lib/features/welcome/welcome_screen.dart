import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/presentation/bloc/auth/auth.dart';
import 'package:good_trip/core/presentation/widgets/empty_list.dart';
import 'package:good_trip/core/presentation/widgets/fail_screen.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/welcome/presentation/bloc/welcome_info.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final controller = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.white,
      body: BlocConsumer<WelcomeInfoBloc, WelcomeInfoState>(
        listener: (context, state) {
          if (state is WelcomeInfoAlreadySeen) {
            BlocProvider.of<AuthBloc>(context)..add(AuthLoadUserEvent());
            context.router.replace(const HomeRoute());
          } else if (state is FirstRun) {
            context.router.replace(const SignInRoute());
          }
        },
        builder: (context, state) {
          if (state is WelcomeInfoInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WelcomeInfoFailure) {
            return const FailScreen();
          } else if (state is WelcomeInfoSuccess) {
            final welcomeInfoList = state.welcomeInfoList;
            if (welcomeInfoList == null || welcomeInfoList.isEmpty) {
              return const EmptyList();
            }
            return PageView.builder(
              controller: controller,
              itemCount: welcomeInfoList.length,
              itemBuilder: (_, index) {
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height,
                      child: Image.network(
                        welcomeInfoList[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Spacer(),
                          Text(
                            welcomeInfoList[index].text,
                            style: AppTextTheme.bold30,
                          ),
                          Text(
                            welcomeInfoList[index].subtext,
                            style: AppTextTheme.normal15,
                          ),
                          if (index == welcomeInfoList.length - 1)
                            Padding(
                              padding: const EdgeInsets.only(top: 34.0),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      BlocProvider.of<WelcomeInfoBloc>(context)..add(const SetFirstRun());
                                    },
                                    child: Container(
                                      height: 44,
                                      width: 102,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: AppColors.pink,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Начать',
                                          style: AppTextTheme.semiBold15.copyWith(
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 28,
                          ),
                          SmoothPageIndicator(
                            controller: controller,
                            count: welcomeInfoList.length,
                            effect: const ExpandingDotsEffect(
                              expansionFactor: 5,
                              activeDotColor: AppColors.white,
                              dotColor: AppColors.white,
                              dotHeight: 5,
                              dotWidth: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
