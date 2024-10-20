import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/theme/app_colors.dart';
import 'package:good_trip/core/theme/app_text_theme.dart';
import 'package:good_trip/features/tour_create/presentation/bloc/tour_create.dart';

class WeekdayWidget extends StatelessWidget {
  const WeekdayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final WeekdayCubit cubit = WeekdayCubit();
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.pink,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WeekdayCubit, WeekdayState>(
          bloc: cubit,
          builder: (context, state) {
            final days = state.days;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: days.map(
                (day) {
                  return Expanded(
                    child: RawMaterialButton(
                      fillColor: day.isSelected ? AppColors.white : null,
                      shape: const CircleBorder(
                        side: BorderSide.none,
                      ),
                      onPressed: () {
                        cubit.selectDay(day.dayName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          day.dayName,
                          style: AppTextTheme.semiBold18.copyWith(
                            color:
                                day.isSelected ? AppColors.pink : AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          }
        ),
      ),
    );
  }
}
