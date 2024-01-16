import 'package:good_trip/repositories/models/event.dart';

abstract class AbstractEventRepository {
  Future<List<Event>> getTripEventList();

  Future<Event> getTripEvent(String idEvent);
}