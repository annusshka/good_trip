import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/presentation/bloc/tour/tour.dart';

import '../../../domain/models/models.dart';
import '../../../theme/theme.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({super.key, required this.iconSize, required this.tour});

  final BaseTour tour;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        tour.isLiked ? Icons.favorite : Icons.favorite_border,
        size: iconSize,
        color: colors.white,
      ),
      onPressed: () {
        tour.isLiked = !tour.isLiked;
        BlocProvider.of<TourBloc>(context).add(TourLikeRequested(id: tour.id));
      },
    );
  }
}
