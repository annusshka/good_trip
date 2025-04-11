import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/excursion/excursion.dart';
import 'package:good_trip/core/presentation/widgets/excursion_grid.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/core/theme/strings.dart';
import 'package:good_trip/features/favorite/presentation/widgets/empty_favourites.dart';

import 'bloc/favorite_list.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocListener<ExcursionBloc, ExcursionState>(
      listener: (context, state) {
        if (state is ExcursionLikedSuccess) {
          BlocProvider.of<FavoriteListBloc>(context)
              .add(const FavoriteListRequested());
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          title: const Text(
            favorites,
            style: AppTextTheme.semiBold26,
          ),
        ),
        body: BlocBuilder<FavoriteListBloc, FavoriteListState>(
            builder: (context, state) {
          if (state is FavoriteListLoadedSuccess) {
            if (state.tourList.isEmpty) {
              return const EmptyFavourites();
            }
            return ExcursionGrid(
              excursionList: state.tourList,
            );
          } else if (state is FavoriteListLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
