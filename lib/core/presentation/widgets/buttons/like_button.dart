import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/bloc.dart';
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
    final favouriteAudioExcursionCubit = context.read<FavouriteExcursionCubit>();

    return BlocBuilder<FavouriteExcursionCubit, FavouriteExcursionState>(
      bloc: favouriteAudioExcursionCubit,
      builder: (context, state) {
        return InkWell(
          child: Icon(
            excursion.isLiked ? Icons.favorite : Icons.favorite_border,
            size: iconSize,
            color: iconColor,
          ),
          onTap: () async {
            excursion.isLiked = !excursion.isLiked;
            final successLiked = await favouriteAudioExcursionCubit.likeAudioExcursion(
              isLiked: excursion.isLiked,
              excursion: excursion as AudioExcursion,
              excursionList: state.favouriteAudioExcursionList,
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
