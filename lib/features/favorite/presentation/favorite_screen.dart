import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/excursion/excursion.dart';
import 'package:good_trip/core/presentation/bloc/tour/tour.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/favorite/presentation/bloc/favorite_excursion_list/favorite_excursion_list.dart';
import 'package:good_trip/features/favorite/presentation/bloc/favorite_tour_list/favorite_tour_list.dart';
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
                    text: 'Понравившиеся экскурсии',
                  ),
                  const Tab(
                    text: 'Понравившиеся туры',
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            BlocListener<ExcursionBloc, ExcursionState>(
              listener: (context, state) {
                if (state is ExcursionLikedSuccess) {
                  BlocProvider.of<FavoriteExcursionListBloc>(context).add(const FavoriteExcursionListRequested());
                }
              },
              child: BlocBuilder<FavoriteExcursionListBloc, FavoriteExcursionListState>(
                builder: (context, state) {
                  if (state is FavoriteExcursionListLoadedSuccess) {
                    if (state.excursionList.isEmpty) {
                      return const EmptyFavourites();
                    }
                    return ExcursionGrid(
                      excursionList: state.excursionList,
                    );
                  } else if (state is FavoriteExcursionListLoadInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            BlocListener<TourBloc, TourState>(
              listener: (context, state) {
                if (state is TourLikedSuccess) {
                  BlocProvider.of<FavoriteTourListBloc>(context).add(const FavoriteTourListRequested());
                }
              },
              child: BlocBuilder<FavoriteTourListBloc, FavoriteTourListState>(
                builder: (context, state) {
                  if (state is FavoriteTourListLoadedSuccess) {
                    if (state.tourList.isEmpty) {
                      return const EmptyFavourites();
                    }
                    return TourGrid(
                      tourList: state.tourList,
                    );
                  } else if (state is FavoriteExcursionListLoadInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
