import 'package:day_picker/day_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:good_trip/core/data/models/enum/enum.dart';

import 'weekday_state.dart';

class WeekdayCubit extends Cubit<WeekdayState> {
  WeekdayCubit()
      : super(WeekdayState(weekdayList: [], days: [
          DayInWeek(
            'Пн',
            dayKey: Weekday.monday.name,
          ),
          DayInWeek(
            'Вт',
            dayKey: Weekday.tuesday.name,
          ),
          DayInWeek(
            'Ср',
            dayKey: Weekday.wednesday.name,
          ),
          DayInWeek(
            'Чт',
            dayKey: Weekday.thursday.name,
          ),
          DayInWeek(
            'Пт',
            dayKey: Weekday.friday.name,
          ),
          DayInWeek(
            'Сб',
            dayKey: Weekday.saturday.name,
          ),
          DayInWeek(
            'Вс',
            dayKey: Weekday.sunday.name,
          ),
        ]));

  void selectDay(final String name) {
    DayInWeek selectedDay =
        state.days.firstWhere((value) => value.dayName.contains(name));
    final index = state.days.indexOf(selectedDay);
    selectedDay.isSelected = !selectedDay.isSelected;
    state.days.replaceRange(index, index + 1, [selectedDay]);
    emit(WeekdayState(weekdayList: state.weekdayList, days: state.days));
  }

  void clearWeekdays() {
    state.days.forEach((value) {
      if (value.isSelected == true) {
        value.isSelected = false;
      }
    });
  }
}
