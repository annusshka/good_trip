import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/excursion/excursion.dart';
import 'package:good_trip/core/presentation/widgets/buttons/buttons.dart';
import 'package:good_trip/core/presentation/widgets/excursion_photo.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

class TourScrollElement extends StatelessWidget {
  const TourScrollElement({
    super.key,
    required this.tour,
    this.onTapAction,
  });

  final ITour tour;
  final Function(ITour)? onTapAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 248,
      width: 150,
      child: InkWell(
        onTap: () {
          //onTapAction != null ? onTapAction!(tour) : context.router.push(ExcursionRoute(excursion: tour));
        },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ExcursionPhoto(
                        photoUrl: tour.imageUrl,
                        icon: tour is Excursion ? Icons.photo_camera : Icons.headphones_rounded,
                        size: 50,
                      ),
                      if (tour is! Excursion)
                        Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<ExcursionBloc, ExcursionState>(builder: (context, state) {
                            return TourLikeButton(
                              iconSize: 24,
                              tour: tour,
                            );
                          }),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        tour.kinds[0],
                        style: AppTextTheme.medium10.copyWith(
                          color: AppColors.lightGray,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        tour.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextTheme.semiBold18,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}