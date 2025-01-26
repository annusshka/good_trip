import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/tour/presentation/widgets/audio_con.dart';

class ExcursionCard extends StatelessWidget {
  const ExcursionCard({
    super.key,
    required this.excursion,
  });

  final AudioExcursion excursion;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154.0,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGray.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 8,
            offset: const Offset(3, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: ExcursionPhoto(
                  photoUrl: excursion.imageUrl,
                  icon: Icons.camera_alt,
                  size: 30.0,
                  boxFit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                color: AppColors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              excursion.name,
                              textAlign: TextAlign.left,
                              style: AppTextTheme.semiBold15,
                            ),
                            Text(
                              excursion.getWeekdays(),
                              textAlign: TextAlign.left,
                              style: AppTextTheme.semiBold12,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: LikeButton(
                            iconSize: 24,
                            excursion: excursion,
                            iconColor: AppColors.lightGray,
                          ),
                        ),
                      ],
                    ),
                    const AudioCon(),
                    // AudioContainer(
                    //   audioFilePath: excursion.audioUrl,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
