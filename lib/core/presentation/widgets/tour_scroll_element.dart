import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/bloc/tour/tour.dart';
import 'package:good_trip/core/presentation/widgets/buttons/buttons.dart';
import 'package:good_trip/core/presentation/widgets/tour_photo.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

class TourScrollElement extends StatelessWidget {
  const TourScrollElement({
    super.key,
    required this.tour,
  });

  final ITour tour;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 248,
      width: 150,
      child: InkWell(
        onTap: () {
          context.router.push(
            TourRoute(
              tour: tour,
            ),
          );
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
                      TourPhoto(
                          photoUrl: tour.image,
                          icon: tour is Tour
                              ? Icons.photo_camera
                              : Icons.headphones_rounded,
                          size: 50),
                      Align(
                        alignment: Alignment.topRight,
                        child: BlocBuilder<TourBloc, TourState>(
                            builder: (context, state) {
                          return LikeButton(
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
