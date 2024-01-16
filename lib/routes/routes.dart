import 'package:good_trip/features/event/view/event_screen.dart';
import 'package:good_trip/features/event_list/view/event_list_screen.dart';

final route = {
  '/': (context) => const EventListScreen(),
  '/event': (context) => const EventScreen(),
};