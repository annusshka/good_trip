import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/excursion/excursion.dart';
import 'package:good_trip/core/theme/app_colors.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    super.key,
    required this.iconSize,
    required this.excursion,
    this.iconColor = AppColors.white,
  });

  final IExcursion excursion;
  final double iconSize;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        excursion.isLiked ? Icons.favorite : Icons.favorite_border,
        size: iconSize,
        color: iconColor,
      ),
      onTap: () {
        excursion.isLiked = !excursion.isLiked;
        BlocProvider.of<ExcursionBloc>(context).add(
          ExcursionLikeRequested(
            id: excursion.id,
            isLiked: excursion.isLiked,
          ),
        );
      },
    );
  }
}
