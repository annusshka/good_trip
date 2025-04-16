import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/bloc.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/favorite/presentation/widgets/empty_favourites.dart';

@RoutePage()
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with SingleTickerProviderStateMixin {
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
                    text: 'Экскурсии',
                  ),
                  const Tab(
                    text: 'Туры',
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            BlocBuilder<FavouriteExcursionCubit, FavouriteExcursionState>(
              bloc: context.read<FavouriteExcursionCubit>(),
              builder: (context, state) {
                final excursionList = state.favouriteAudioExcursionList;
                if (excursionList == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (excursionList.isEmpty) {
                  return const EmptyFavourites();
                } else {
                  return ExcursionGrid(excursionList: excursionList);
                }
              },
            ),
            BlocBuilder<FavouriteTourCubit, FavouriteTourState>(
              bloc: context.read<FavouriteTourCubit>(),
              builder: (context, state) {
                final tourList = state.favouriteTourList;
                if (tourList == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (tourList.isEmpty) {
                  return const EmptyFavourites();
                } else {
                  return TourGrid(tourList: tourList);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
