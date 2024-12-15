import 'package:auto_route/auto_route.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/data/models/audio_excursion/audio_excursion.dart';
import 'package:good_trip/core/data/models/excursion/i_excursion.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/tour/presentation/widgets/excursion_card.dart';

import '../bloc/viewed_excursions/viewed_excursions.dart';

class ExcursionList extends StatelessWidget {
  const ExcursionList({
    super.key,
    required this.excursionList,
    required this.tourId,
  });

  final List<IExcursion> excursionList;
  final String tourId;

  @override
  Widget build(BuildContext context_) {
    return BlocBuilder<ViewedExcursionsBloc, ViewedExcursionsState>(
        builder: (context, state) {
      if (state is ViewedExcursionsInitial) {
        BlocProvider.of<ViewedExcursionsBloc>(context).add(
          ViewedExcursionRequested(tourId: tourId),
        );
      }
      return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          late final Color actualColor;
          late final Color actualColor2;
          late final int actualCount;

          if (state is LoadViewedExcursionsSuccess &&
              index < state.excursionCount) {
            actualColor = AppColors.pink;
            actualCount = state.excursionCount;
          } else {
            actualColor = AppColors.lightGray;
            actualCount = 0;
          }
          if (state is LoadViewedExcursionsSuccess &&
              index <= state.excursionCount) {
            actualColor2 = AppColors.pink;
          } else {
            actualColor2 = AppColors.lightGray;
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
                            ? Expanded(
                                child: DottedLine(
                                  direction: Axis.vertical,
                                  dashColor: actualColor2,
                                ),
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
                        child: index != excursionList.length - 1
                            ? Expanded(
                                child: DottedLine(
                                  direction: Axis.vertical,
                                  dashColor: actualColor2,
                                ),
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
                      BlocProvider.of<ViewedExcursionsBloc>(context).add(
                        ViewExcursionRequested(
                          tourId: tourId,
                          excursionCount: index + 1,
                          actualCount: actualCount,
                        ),
                      );
                      AutoRouter.of(context).navigate(
                          ExcursionRoute(excursion: excursionList[index]));
                    },
                    child: ExcursionCard(
                        excursion: excursionList[index] as AudioExcursion),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: excursionList.length,
      );
    });
  }
}
