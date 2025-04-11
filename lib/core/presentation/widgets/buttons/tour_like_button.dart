import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/tour/tour.dart';
import 'package:good_trip/core/theme/app_colors.dart';

class TourLikeButton extends StatelessWidget {
  const TourLikeButton({
    super.key,
    required this.iconSize,
    required this.tour,
    this.iconColor = AppColors.white,
  });

  final ITour tour;
  final double iconSize;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        tour.isLiked ? Icons.favorite : Icons.favorite_border,
        size: iconSize,
        color: iconColor,
      ),
      onTap: () {
        tour.isLiked = !tour.isLiked;
        BlocProvider.of<TourBloc>(context).add(TourLikeRequested(id: tour.id));
      },
    );
  }
}
