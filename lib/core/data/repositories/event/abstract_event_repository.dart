import 'package:good_trip/core/data/models/models.dart';

abstract class AbstractEventRepository {
  Future<List<Tour>> getTripEventList();

  Future<Tour> getTripEvent(String idEvent);
}