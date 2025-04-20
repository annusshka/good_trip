import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/audio_player/excursion_list/widgets/widgets.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/tour/presentation/bloc/viewed_excursions/viewed_excursions.dart';

class ExcursionListView extends StatelessWidget {
  const ExcursionListView({
    super.key,
    required this.viewedExcursionCount,
    required this.tour,
  });

  final int viewedExcursionCount;
  final Tour tour;

  @override
  Widget build(BuildContext context_) {
    final viewedExcursionsCubit = context_.read<ViewedExcursionsCubit>();

    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        late final Color actualColor;
        late final Color actualColorDot;
        late final Color actualColorDot2;
        late final int actualCount;

        if (index < viewedExcursionCount) {
          actualColor = AppColors.pink;
          actualColorDot = AppColors.pink;
          actualColorDot2 = AppColors.pink;
          actualCount = viewedExcursionCount;
        } else {
          actualColor = AppColors.lightGray;
          actualColorDot2 = AppColors.lightGray;
          actualColorDot = index == viewedExcursionCount ? AppColors.pink : AppColors.lightGray;
          actualCount = 0;
        }

        return SizedBox(
          height: 178.0,
          child: Row(
            children: [
              Container(
                width: 30,
                height: 178.0,
                child: Column(
                  children: [
                    SizedBox(
                      height: 75,
                      child: index != 0
                          ? DottedLine(
                              direction: Axis.vertical,
                              dashColor: actualColorDot,
                            )
                          : null,
                    ),
                    const Spacer(),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: actualColor,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          textAlign: TextAlign.center,
                          style: AppTextTheme.semiBold15.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 75,
                      child: index != tour.excursionList.length - 1
                          ? DottedLine(
                              direction: Axis.vertical,
                              dashColor: actualColorDot2,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    viewedExcursionsCubit.requestViewExcursion(
                      tourId: tour.id,
                      excursionCount: index + 1,
                      actualCount: actualCount,
                    );
                  },
                  child: ExcursionCardView(
                    excursion: tour.excursionList[index],
                    index: index,
                    tourName: '${tour.id}_${tour.name}',
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: tour.excursionList.length,
    );
  }
}
