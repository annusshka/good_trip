import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/presentation/widgets/excursion_photo.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/excursion/presentation/widgets/widgets.dart';
import 'package:good_trip/features/excursion_create/presentation/bloc/excursion_create.dart';

class ExcursionCreateListElement extends StatelessWidget {
  const ExcursionCreateListElement(
      {super.key, required this.excursion, required this.iconSize});

  final IExcursion excursion;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Container(
      height: height * 0.5,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGray),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: InkWell(
        onTap: () {
          context.router.navigate(ExcursionRoute(excursion: excursion));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: ExcursionPhoto(
                      photoUrl: excursion.imageUrl,
                      icon: Icons.headphones_rounded,
                      size: height * 0.1,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  excursion.name,
                  textAlign: TextAlign.left,
                  style: AppTextTheme.semiBold26,
                ),
              ),
              Flexible(
                child: Text(
                  excursion.getKinds(),
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: 1,
                  style: AppTextTheme.medium14.copyWith(
                    color: AppColors.lightGray,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: TourTile(
                  titleText: excursion.getWeekdays(),
                  subtitleText: '8:00 - 20:00',
                  icon: Icons.calendar_today_rounded,
                ),
              ),
              Flexible(
                flex: 2,
                child: TourTile(
                  titleText: excursion.getAddressDetails(),
                  subtitleText: excursion.getAddressRegion(),
                  icon: Icons.location_on_outlined,
                ),
              ),
              Flexible(
                flex: 3,
                child: BlocBuilder<ExcursionCreateBloc, ExcursionCreateState>(
                    builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.only(top: height * 0.02),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        color: AppColors.pink,
                        child: TextButton(
                          onPressed: () {
                            BlocProvider.of<ExcursionCreateBloc>(context).add(
                              CreatedExcursionRemoveRequested(
                                tourId: excursion.id,
                                context: context,
                              ),
                            );
                          },
                          child: Text(
                            'Удалить',
                            style: AppTextTheme.medium15.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
