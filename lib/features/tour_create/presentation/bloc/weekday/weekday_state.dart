import 'package:day_picker/day_picker.dart';
import 'package:good_trip/core/data/models/enum/enum.dart';

class WeekdayState {
  final List<Weekday>? weekdayList;
  final List<DayInWeek> days;

  const WeekdayState({required this.weekdayList, required this.days});
}