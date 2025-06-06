import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/audio_player/excursion_list/widgets/widgets.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/widgets/widgets.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

class ExcursionCardView extends StatelessWidget {
  const ExcursionCardView({
    super.key,
    required this.excursion,
    required this.index,
    this.tourName,
  });

  final AudioExcursion excursion;
  final int index;
  final String? tourName;

  @override
  Widget build(BuildContext context) {
    final weekdays = excursion.getWeekdays();

    return Container(
      height: 154.0,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGray.withValues(alpha: 0.5),
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
                child: Image.network(
                  excursion.imageUrl ?? '',
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: const Icon(Icons.camera_alt, size: 30.0,),
                    );
                  },
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          excursion.name,
                          textAlign: TextAlign.left,
                          style: AppTextTheme.semiBold15,
                        ),
                        Row(
                          children: [
                            Text(
                              weekdays.isNotEmpty ? weekdays : 'Любой день',
                              textAlign: TextAlign.left,
                              style: AppTextTheme.semiBold12,
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: InkWell(
                                onTap: () => context.router.push(
                                  ExcursionRoute(
                                    excursion: excursion,
                                    tourName: tourName,
                                  ),
                                ),
                                child: Text(
                                  'Подробнее...',
                                  textAlign: TextAlign.right,
                                  style: AppTextTheme.semiBold12.copyWith(
                                    color: AppColors.pink,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    AudioContainer(
                      index: index,
                    ),
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
