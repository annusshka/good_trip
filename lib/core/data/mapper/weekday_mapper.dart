import 'package:day_picker/day_picker.dart';
import 'package:good_trip/core/data/models/enum/enum.dart';

Weekday mapDayInWeekToWeekday(DayInWeek day) {
  for (final Weekday weekday in Weekday.values) {
    if (weekday.name == day.dayName) return weekday;
  }

  return Weekday.monday;
}

List<Weekday> mapToWeekdayList(List<DayInWeek> days) {
  List<Weekday> weekdays = [];
  for (final DayInWeek day in days) {
    if (day.isSelected) {
      weekdays.add(mapDayInWeekToWeekday(day));
    }
  }

  return weekdays;
}