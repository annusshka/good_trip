import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:good_trip/core/theme/theme.dart';

List<DayInWeek> _days = [
  DayInWeek(
    "Пн",
    dayKey: 'Пн',
  ),
  DayInWeek("Вт", dayKey: 'Вт'),
  DayInWeek(
    "Ср",
    dayKey: 'Ср',
  ),
  DayInWeek(
    "Чт",
    dayKey: 'Чт',
  ),
  DayInWeek(
    "Пт",
    dayKey: 'Пт',
  ),
  DayInWeek(
    "Сб",
    dayKey: 'Сб',
  ),
  DayInWeek(
    "Вс",
    dayKey: 'Вс',
  ),
];

class WeekdayWidget extends StatelessWidget {
  const WeekdayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectWeekDays(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      days: _days,
      border: false,
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colors.pink_,
      ),
      onSelect: (values) {
        // <== Callback to handle the selected days
      },
    );
    /*
      Container(
      color: colors.gray,
      width: 40,
      child: Column(children: [
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
                color: colors.lightGray,
                width: 35,
                alignment: Alignment.center,
                child: Text(
                  Weekday.values[dayNumber].displayTitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
          ),
        ),
        const Spacer()
      ]),
    );*/
  }
}
