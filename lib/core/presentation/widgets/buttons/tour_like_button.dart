import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/bloc.dart';
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
    final favouriteTourCubit = context.read<FavouriteTourCubit>();

    return BlocBuilder<FavouriteTourCubit, FavouriteTourState>(
      bloc: favouriteTourCubit,
      builder: (context, state) {
        return InkWell(
          child: Icon(
            tour.isLiked ? Icons.favorite : Icons.favorite_border,
            size: iconSize,
            color: iconColor,
          ),
          onTap: () async {
            tour.isLiked = !tour.isLiked;
            final successLiked = await favouriteTourCubit.likeTour(
              tour: tour as Tour,
              isLiked: tour.isLiked,
              tourList: state.favouriteTourList,
            );
            if (!successLiked) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: AppColors.pink,
                  content: Text(
                    'Ошибка добавления в избранное',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
