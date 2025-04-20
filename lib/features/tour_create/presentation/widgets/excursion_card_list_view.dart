import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/widgets.dart';
import 'package:good_trip/core/audio_player/excursion_list/widgets/widgets.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/tour_create/presentation/widgets/add_excursion_card.dart';

class ExcursionCardListView extends StatelessWidget {
  const ExcursionCardListView({
    super.key,
    required this.excursionList,
    required this.tourName,
    this.onTapAction,
  });

  final Function(IExcursion)? onTapAction;
  final List<AudioExcursion> excursionList;
  final String tourName;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final Color actualColor = index < excursionList.length ? AppColors.pink : AppColors.lightGray;
        final Color actualColor2 = index <= excursionList.length ? AppColors.pink : AppColors.lightGray;

        return SizedBox(
          height: 178.0,
          child: Row(
            children: [
              Container(
                width: 30,
                child: Column(
                  children: [
                    if (index != 0)
                      Expanded(
                        child: DottedLine(
                          direction: Axis.vertical,
                          dashColor: actualColor2,
                        ),
                      )
                    else
                      const SizedBox(height: 75),
                    const SizedBox(height: 5),
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
                    const SizedBox(height: 5),
                    if (index != excursionList.length)
                      Expanded(
                        child: DottedLine(
                          direction: Axis.vertical,
                          dashColor: actualColor,
                        ),
                      )
                    else
                      const SizedBox(height: 73),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: index != excursionList.length
                    ? ExcursionCardView(
                        excursion: excursionList[index],
                        index: index,
                        tourName: tourName,
                      )
                    : AddExcursionCard(
                        onTapAction: onTapAction,
                      ),
              ),
            ],
          ),
        );
      },
      itemCount: excursionList.length + 1,
    );
  }
}
