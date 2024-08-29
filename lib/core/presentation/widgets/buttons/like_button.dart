import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/tour/tour.dart';
import 'package:good_trip/core/theme/app_colors.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({super.key, required this.iconSize, required this.tour});

  final ITour tour;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        tour.isLiked ? Icons.favorite : Icons.favorite_border,
        size: iconSize,
        color: AppColors.white,
      ),
      onPressed: () {
        tour.isLiked = !tour.isLiked;
        BlocProvider.of<TourBloc>(context).add(TourLikeRequested(id: tour.id));
      },
    );
  }
}
