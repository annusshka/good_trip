import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/widgets/empty_list.dart';
import 'package:good_trip/core/presentation/widgets/tour_grid.dart';
import 'package:good_trip/core/theme/strings.dart';

import '../../../core/presentation/bloc/tour/tour.dart';
import 'bloc/favorite_list.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocListener<TourBloc, TourState>(
      listener: (context, state) {
        if (state is TourLikedSuccess) {
          BlocProvider.of<FavoriteListBloc>(context)
              .add(const FavoriteListRequested());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            favorites,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: BlocBuilder<FavoriteListBloc, FavoriteListState>(
            builder: (context, state) {
          if (state is FavoriteListLoadedSuccess) {
            if (state.tourList.isEmpty) {
              return const EmptyList();
            }
            return TourGrid(
              tourList: state.tourList,
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
