import 'package:auto_route/auto_route.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/app_router/app_router.dart';
import 'package:good_trip/core/audio_player/data/queue_state.dart';
import 'package:good_trip/core/audio_player/presentation/bloc/audio_player.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/tour/presentation/widgets/excursion_card.dart';

import '../bloc/viewed_excursions/viewed_excursions.dart';

class ExcursionList extends StatelessWidget {
  const ExcursionList({
    super.key,
    required this.excursionList,
    required this.tour,
  });

  final List<IExcursion> excursionList;
  final ITour tour;

  @override
  Widget build(BuildContext context_) {
    final cubit = context_.read<AudioPlayerCubit>();

    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      builder: (context, audioState) {
        if (audioState is AudioPlayerInitial) {
          cubit.loadTour(
            excursionList: excursionList as List<AudioExcursion>,
            tourName: tour.name,
          );
        }
        return BlocBuilder<ViewedExcursionsBloc, ViewedExcursionsState>(
          builder: (context, state) {
            if (state is ViewedExcursionsInitial) {
              BlocProvider.of<ViewedExcursionsBloc>(context).add(
                ViewedExcursionRequested(tourId: tour.id),
              );
            }
            if (state is LoadViewedExcursionsSuccess) {
              return StreamBuilder<QueueState>(
                stream: cubit.audioPlayerHandler.queueState,
                builder: (context, snapshot) {

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      late final Color actualColor;
                      late final Color actualColor2;
                      late final int actualCount;

                      if (index < state.excursionCount) {
                        actualColor = AppColors.pink;
                        actualColor2 = AppColors.pink;
                        actualCount = state.excursionCount;
                      } else {
                        actualColor = AppColors.lightGray;
                        actualColor2 = index == state.excursionCount
                            ? AppColors.pink
                            : AppColors.lightGray;
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
                                  BlocProvider.of<ViewedExcursionsBloc>(context)
                                      .add(
                                    ViewExcursionRequested(
                                      tourId: tour.id,
                                      excursionCount: index + 1,
                                      actualCount: actualCount,
                                    ),
                                  );
                                  AutoRouter.of(context).push(
                                    ExcursionRoute(
                                      excursion: excursionList[index],
                                    ),
                                  );
                                },
                                child: ExcursionCard(
                                  excursion:
                                      excursionList[index] as AudioExcursion,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: excursionList.length,
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
