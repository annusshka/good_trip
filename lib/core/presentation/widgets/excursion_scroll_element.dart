import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/widgets/buttons/buttons.dart';
import 'package:good_trip/core/presentation/widgets/excursion_photo.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';

class ExcursionScrollElement extends StatelessWidget {
  const ExcursionScrollElement({
    super.key,
    required this.excursion,
    this.onTapAction,
  });

  final IExcursion excursion;
  final Function(IExcursion)? onTapAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 248,
      width: 150,
      child: InkWell(
        onTap: () {
          onTapAction != null ? onTapAction!(excursion) : context.router.push(ExcursionRoute(excursion: excursion));
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
                        photoUrl: excursion.imageUrl,
                        icon: excursion is Excursion ? Icons.photo_camera : Icons.headphones_rounded,
                        size: 50,
                      ),
                      if (excursion is! Excursion)
                        Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.all(8.0),
                          child: LikeButton(
                            iconSize: 24,
                            excursion: excursion,
                          ),
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
                        excursion.kinds[0].displayText,
                        style: AppTextTheme.medium10.copyWith(
                          color: AppColors.lightGray,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        excursion.name.isNotEmpty ? excursion.name : 'Экскурсия ${excursion.id}',
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
