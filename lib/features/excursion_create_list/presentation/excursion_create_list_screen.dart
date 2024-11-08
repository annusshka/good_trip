import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/presentation/bloc/excursion_create_list/excursion_create_list.dart';
import 'package:good_trip/core/presentation/bloc/tour_create_list/tour_create_list.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';

import 'widgets/tour_create_list_element.dart';

@RoutePage()
class ExcursionCreateListScreen extends StatelessWidget {
  const ExcursionCreateListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return BlocListener<ExcursionCreateBloc, ExcursionCreateState>(
      listener: (BuildContext context, ExcursionCreateState state) {
        if (state is ExcursionCreatedSuccess ||
            state is ExcursionRemovedSuccess) {
          BlocProvider.of<ExcursionCreateListBloc>(context).add(
            const ExcursionListCreateByActualUserRequested(),
          );
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            //backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: const Text(
              'Мои экскурсии',
              style: AppTextTheme.semiBold26,
            ),
            bottom: TabBar(
              indicatorColor: AppColors.pink,
              labelStyle: AppTextTheme.medium14.copyWith(
                color: AppColors.pink,
              ),
              unselectedLabelStyle: AppTextTheme.medium14.copyWith(
                color: AppColors.gray,
              ),
              tabs: [
                const Tab(
                  text: 'Экскурсии',
                ),
                const Tab(
                  text: 'Туры',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BlocBuilder<ExcursionCreateListBloc, ExcursionCreateListState>(
                builder: (context, state) {
                  if (state is ExcursionCreateListLoadedSuccess) {
                    if (state.excursionList.isEmpty) {
                      return const EmptyList();
                    }
                    return ListView.separated(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: 15.0,
                      ),
                      itemCount: state.excursionList.length,
                      separatorBuilder: (BuildContext context, _) => SizedBox(
                        height: height * 0.03,
                      ),
                      itemBuilder: (context, i) {
                        return ExcursionCreateListElement(
                          tour: state.excursionList[i],
                          iconSize: height * 0.3 * 0.3,
                        );
                      },
                    );
                  }
                  if (state is ExcursionCreateListLoadInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              BlocBuilder<TourCreateListBloc, TourCreateListState>(
                builder: (context, state) {
                  if (state is TourCreateListLoadedSuccess) {
                    if (state.tourList.isEmpty) {
                      return const EmptyList();
                    }
                    return ListView.separated(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: 15.0,
                      ),
                      itemCount: state.tourList.length,
                      separatorBuilder: (BuildContext context, _) => SizedBox(
                        height: height * 0.03,
                      ),
                      itemBuilder: (context, i) {
                        return TourCreateListElement(
                          tour: state.tourList[i],
                          iconSize: height * 0.3 * 0.3,
                        );
                      },
                    );
                  }
                  if (state is TourCreateListLoadInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.pink,
            onPressed: () {
              AutoRouter.of(context).push(const ExcursionCreateRoute());
            },
            child: const Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
