import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/presentation/bloc/bloc.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';
import 'package:good_trip/features/excursion_create_list/presentation/widgets/excursion_list.dart';
import 'package:good_trip/features/excursion_create_list/presentation/widgets/tour_list.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create/tour_create.dart';

@RoutePage()
class ExcursionCreateListScreen extends StatefulWidget {
  const ExcursionCreateListScreen({super.key});

  @override
  State<ExcursionCreateListScreen> createState() => _ExcursionCreateListScreenState();
}

class _ExcursionCreateListScreenState extends State<ExcursionCreateListScreen> with SingleTickerProviderStateMixin {
  late final _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                controller: _tabController,
                indicatorColor: AppColors.pink,
                labelStyle: AppTextTheme.semiBold18.copyWith(
                  color: AppColors.pink,
                ),
                unselectedLabelStyle: AppTextTheme.semiBold18.copyWith(
                  color: AppColors.lightGray,
                ),
                tabs: [
                  const Tab(
                    text: 'Мои экскурсии',
                  ),
                  const Tab(
                    text: 'Мои туры',
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            BlocListener<ExcursionCreateBloc, ExcursionCreateState>(
              listener: (BuildContext context, ExcursionCreateState state) {
                if (state is ExcursionCreatedSuccess || state is ExcursionRemovedSuccess) {
                  BlocProvider.of<ExcursionCreateListBloc>(context).add(
                    const ExcursionListCreateByActualUserRequested(),
                  );
                }
              },
              child: const ExcursionList(),
            ),
            BlocListener<TourCreateBloc, TourCreateState>(
              listener: (BuildContext context, TourCreateState state) {
                if (state is TourCreatedSuccess || state is TourRemovedSuccess) {
                  BlocProvider.of<TourCreateListBloc>(context).add(
                    const ToursCreateByActualUserRequested(),
                  );
                }
              },
              child: const TourList(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.pink,
          onPressed: _openCreateScreen,
          child: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  void _openCreateScreen() {
    final actualTab = _tabController.index;

    if (actualTab == 0) {
      AutoRouter.of(context).push(const ExcursionCreateRoute());
    } else {
      AutoRouter.of(context).push(const TourCreateRoute());
    }
  }
}
