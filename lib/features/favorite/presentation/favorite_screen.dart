import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/widgets/tour_grid.dart';
import 'package:good_trip/features/favorite/presentation/bloc/tour_bloc.dart';
import 'package:good_trip/features/favorite/presentation/bloc/tour_event.dart';

import 'bloc/tour_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //lazy: false,
      create: (context) => TourBloc()..add(const TourRequested(lon: '38.364285', lat: '59.855685')),
      child: BlocBuilder<TourBloc, TourState>(
        builder: (context, state) {
          if (state is TourListLoadedSuccess) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Избранное',
                  style: Theme.of(context).textTheme.titleLarge,),
              ),
              body: TourGrid(tourList: state.tourList,),
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
