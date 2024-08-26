import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/core/data/models/models.dart';
import 'package:good_trip/core/theme/theme.dart';

class WeekdayWidget extends StatelessWidget {
  const WeekdayWidget({super.key, required this.days, required this.func});

  final List<DayInWeek> days;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return SelectWeekDays(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      selectedDayTextColor: colors.darkGray,
      days: days,
      border: false,
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colors.pink_,
      ),
      onSelect: (_) {
        List<Weekday> weekdays = [];
        for (int i = 0; i < days.length; i++) {
          if (days[i].isSelected) {
            weekdays.add(Weekday.values[i]);
          }
        }
        func(weekdays);
      },
    );
  }
}
